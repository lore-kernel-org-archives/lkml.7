Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA55C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76C320718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zgv/AkYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKNTLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:11:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfKNTLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573758703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XB1Zf/ZpUsxeIE2fgo8TYg1AyowvOyj8Umgx+HQXrwQ=;
        b=Zgv/AkYg8L+1SLA9pLtR76CgeX7qLWw/XkeTWlqBRJUnOoFFzw8oezbm0hoOD0Oovbyk9M
        xluz42H7wrLOIlFvzg98c/m/O8yqZVK6niFN0unpijzjV/smXMz+JST9vpzOUjwd7wN5H0
        GOBuAVKDi3yoTv3NyaaCX4vOm+K9muY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-HzmppB_UNrGcJATxAeGCAQ-1; Thu, 14 Nov 2019 14:11:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B9F477;
        Thu, 14 Nov 2019 19:11:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5757B6764C;
        Thu, 14 Nov 2019 19:11:35 +0000 (UTC)
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191113193350.24511-1-longman@redhat.com>
 <20191114174553.GC7222@zn.tnic>
 <8f7e0f4b-5100-67b5-fcb5-f7a968b96110@redhat.com>
 <alpine.DEB.2.21.1911141943150.29616@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7f898fcb-3f0d-c754-f75d-213519e0b417@redhat.com>
Date:   Thu, 14 Nov 2019 14:11:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911141943150.29616@nanos.tec.linutronix.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HzmppB_UNrGcJATxAeGCAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 1:48 PM, Thomas Gleixner wrote:
> On Thu, 14 Nov 2019, Waiman Long wrote:
>> On 11/14/19 12:45 PM, Borislav Petkov wrote:
>>>> -=09/* TAA mitigation is turned off on the cmdline (tsx_async_abort=3D=
off) */
>>>> -=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF)
>>>> +=09/*
>>>> +=09 * TAA mitigation via VERW is turned off if both
>>>> +=09 * tsx_async_abort=3Doff and mds=3Doff are specified.
>>>> +=09 */
>>> So this changes the dependency of switches so if anything, it should be
>>> properly documented first in all three:
>>>
>>> Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
>>> Documentation/x86/tsx_async_abort.rst
>>> Documentation/admin-guide/kernel-parameters.txt
>>>
>>> However, before we do that, we need to agree on functionality:
>> I agree that the documentation needs to be updated. I am going to do
>> that once we have a consensus of what is the right thing to do.
>>> Will the mitigations be disabled only with *both* =3Doff supplied on th=
e
>>> command line or should the mitigations be disabled when *any* of the tw=
o
>>> =3Doff is supplied?
>> The mitigation is disabled only with BOTH =3Doff supplied or
>> "mitigations=3Doff". This is the current behavior. This patch is just to
>> make sure that vulnerabilities files reflect the actual behavior. Of
>> course, we can change it to disable mitigation with either =3Doff if thi=
s
>> is what the consensus turn out to be.
> I think the current behaviour is correct. It's just a coincidence that bo=
th
> issues happen to use the same mitigation technology in the exactly same
> places. So if you leave one on then the other gets mitigated as a side
> effect and the sysfs file should reflect that.
>
> Thanks,
>
> =09tglx
>
Good to hear that. I will send a v2 patch with document update.

Cheers,
Longman

