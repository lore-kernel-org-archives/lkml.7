Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1455CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE12080F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKK9DaXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfKAHMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:12:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51007 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKAHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572592350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+nexqqAfYOM5G5w8RuN2lq0dI5Anu1jJGXCu8wvspA=;
        b=AKK9DaXXBSK3nQfIikTgPbV4Ju0FD9F6rOAQcXw3bndKXkcnY8MQovSG9NxBRDJMnui319
        6yo0rl7WQRpWP+BgggbfUcxl9c0vE/uNiwLO2emSbmoQDSUv6MvP+yhYEwYBVgXl7Blbjr
        ydibSBsepCe3jpAe58Uflp84ngVomcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-1JpmMZcAPqqB0LmvV7w9YQ-1; Fri, 01 Nov 2019 03:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 354BA800D49;
        Fri,  1 Nov 2019 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A628EF6EE;
        Fri,  1 Nov 2019 07:12:14 +0000 (UTC)
Subject: Re: [PATCH 1/2 RESEND v8] x86/kdump: always reserve the low 1M when
 the crashkernel option is specified
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, bhe@redhat.com, dyoung@redhat.com,
        jgross@suse.com, dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, d.hatayama@fujitsu.com,
        horms@verge.net.au, kexec@lists.infradead.org
References: <20191031033517.11282-1-lijiang@redhat.com>
 <20191031033517.11282-2-lijiang@redhat.com>
 <20191031071345.GA17248@nazgul.tnic>
 <fe68b796-c483-20c4-623c-2671c52a3bf9@redhat.com>
 <20191031104748.GC21133@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <2865c4af-5630-9f42-1768-3ad5c90fe6f6@redhat.com>
Date:   Fri, 1 Nov 2019 15:12:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191031104748.GC21133@nazgul.tnic>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1JpmMZcAPqqB0LmvV7w9YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2019=E5=B9=B410=E6=9C=8831=E6=97=A5 18:47, Borislav Petkov =E5=86=
=99=E9=81=93:
> On Thu, Oct 31, 2019 at 05:40:35PM +0800, lijiang wrote:
>> Maybe it should be a separate patch to fix the old compile warnings as f=
ollow.
>> And i should put the patch into this series.
>=20
> Yes, maybe.
>=20
>> commit d2091d1f4f67f1c38293b0e93fdbfefa766940cf (HEAD -> master)
>> Author: Lianbo Jiang <lijiang@redhat.com>
>> Date:   Thu Oct 31 15:48:02 2019 +0800
>>
>>     kexec: Fix i386 build warnings that missed declaration of struct kim=
age
>>    =20
>>     Kbuild test robot reported some build warnings, please refer to the
>>     Link below for details.
>=20
> Explain here what the warnings are, why they trigger and how you're
> fixing it. How a commit message should look like is also explained in
> that document I pointed you at.
>=20

OK, looks better('what-why-how'). I will improve the above log.

> Refering to some link is not what we do in commit messages.
>=20
>>     Add a declaration of struct kimage to fix these compile warnings.
>>    =20
>>     Fixes: dd5f726076cc ("kexec: support for kexec on panic using new sy=
stem call")
>>     Reported-by: kbuild test robot <lkp@intel.com>
>>     Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>     Link: https://lkml.org/lkml/2019/10/30/833
>=20
> *NEVER* use lkml.org or any other external URL for refering to mail
> threads but *always* use our own
>=20
> lkml.kernel.org/r/<Message-ID>
>=20
> redirector. See other tip commits for an example.
>=20

It's useful to me. Thanks.

>>> You can read
>>>
>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>>
>>> in the meantime, especially section
>>>
>>> "9) Don't get discouraged - or impatient"
>>>
>>> while waiting.
>>
>> OK. Thanks.
>=20
> And make sure to read that whole document and also have a look at the
> process document
>=20

I will read the above document carefully. But some of the rules in the docu=
ment are
still easy to be forgot, maybe need to practice repeatedly.

> https://www.kernel.org/doc/html/latest/process/index.html
>=20
> so that you can avoid such mistakes in the future.
>=20

Good suggestions. Thank you so much.

Lianbo

> Thx.
>=20

