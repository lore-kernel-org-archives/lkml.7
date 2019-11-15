Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA3FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEAA20740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk4VZfp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKOOlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:41:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22727 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727557AbfKOOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573828865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rp1tDEj7hPqwDPKUTqY9lzpH8nkeKww1ZAVKexcdNpg=;
        b=Lk4VZfp1psLVSjjJnzWItYvnbvoKOEkiBMUzi9Mb+aMTPl0+LfDDFR86ueQCosqiXZFfd+
        GczFCSMeFdbfkQXgizc1bWfpQBZ+HoiqLHPyF4kQU6uxInDCDiapFCzckxfKrHqfHblxmd
        aWktEnqVAg54KoM+V8Io21MTljwzlFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-ung-UjkxP4ukYHdc7kQfjQ-1; Fri, 15 Nov 2019 09:41:00 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6184A1852E21;
        Fri, 15 Nov 2019 14:40:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 194C51036C7B;
        Fri, 15 Nov 2019 14:40:57 +0000 (UTC)
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191113193350.24511-1-longman@redhat.com>
 <20191114201258.GA18745@guptapadev.amr>
 <71de9e2b-19b6-161a-2f78-093c71d9391d@redhat.com>
 <20191114220924.GE7222@zn.tnic>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a924b8f8-7f34-0144-74d1-4d2ba09341dc@redhat.com>
Date:   Fri, 15 Nov 2019 09:40:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191114220924.GE7222@zn.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ung-UjkxP4ukYHdc7kQfjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 5:09 PM, Borislav Petkov wrote:
> On Thu, Nov 14, 2019 at 04:58:24PM -0500, Waiman Long wrote:
>>> Maybe delay MDS mitigation print till TAA is evaluated.
>> I will see what can be done about that. However, this is not a critical
>> issue and I may not change it if there is no easy solution.
> Swapping the two mitigation selection calls in check_bugs() might
> work...

Not really. If taa_select_mitigation() goes first and with
"tsx_async_abort=3Doff" only, the mds file is correct, but the taa file
will be wrong.

Cheers,
Longman

