Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CCC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2120723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 21:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evPl+fHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNVsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:48:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbfKNVsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 16:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573768099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuNE7ovvcIybQ6sLHlLrSZwgaAmyZd6ZBnat2/dkwZ4=;
        b=evPl+fHFBdgdqOlcNyt1wLpmjkUtY82XMRICFc9o248Qr36pdf/MwcbkEPkwOtS3GzvNUp
        8JFZLwPErQ2nIFWyXPhm3cpKjNFUgfrEOa0pUD/wI9i2cWUQtl7Oqj3AixBnBoX9G38mr5
        Pcd4JQMOG5yblKVbQY2yoeSA1qe0x3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-yGnTFd4vNTCeXEtTepiogQ-1; Thu, 14 Nov 2019 16:48:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC35801FD2;
        Thu, 14 Nov 2019 21:48:14 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33107101E814;
        Thu, 14 Nov 2019 21:48:13 +0000 (UTC)
Subject: Re: [PATCH] x86/speculation: Fix incorrect MDS/TAA mitigation status
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191113193350.24511-1-longman@redhat.com>
 <20191114201258.GA18745@guptapadev.amr>
 <20191114203517.su2roiygk4htkpc3@treble>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <179c28c6-39b9-6249-fa82-4c51830285e7@redhat.com>
Date:   Thu, 14 Nov 2019 16:48:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191114203517.su2roiygk4htkpc3@treble>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yGnTFd4vNTCeXEtTepiogQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/19 3:35 PM, Josh Poimboeuf wrote:
> On Thu, Nov 14, 2019 at 12:12:58PM -0800, Pawan Gupta wrote:
>> On Wed, Nov 13, 2019 at 02:33:50PM -0500, Waiman Long wrote:
>>> For MDS vulnerable processors with TSX support, enabling either MDS
>>> or TAA mitigations will enable the use of VERW to flush internal
>>> processor buffers at the right code path. IOW, they are either both
>>> mitigated or both not mitigated. However, if the command line options
>>> are inconsistent, the vulnerabilites sysfs files may not report the
>>> mitigation status correctly.
>>>
>>> For example, with only the "mds=3Doff" option:
>>>
>>>   vulnerabilities/mds:Vulnerable; SMT vulnerable
>>>   vulnerabilities/tsx_async_abort:Mitigation: Clear CPU buffers; SMT vu=
lnerable
>>>
>>> The mds vulnerabilities file has wrong status in this case.
>>>
>>> Change taa_select_mitigation() to sync up the two mitigation status
>>> and have them turned off if both "mds=3Doff" and "tsx_async_abort=3Doff=
"
>>> are present.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>  arch/x86/kernel/cpu/bugs.c | 17 +++++++++++++++--
>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>> index 4c7b0fa15a19..418d41c1fd0d 100644
>>> --- a/arch/x86/kernel/cpu/bugs.c
>>> +++ b/arch/x86/kernel/cpu/bugs.c
>>> @@ -304,8 +304,12 @@ static void __init taa_select_mitigation(void)
>>>  =09=09return;
>>>  =09}
>>> =20
>>> -=09/* TAA mitigation is turned off on the cmdline (tsx_async_abort=3Do=
ff) */
>>> -=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF)
>>> +=09/*
>>> +=09 * TAA mitigation via VERW is turned off if both
>>> +=09 * tsx_async_abort=3Doff and mds=3Doff are specified.
>>> +=09 */
>>> +=09if (taa_mitigation =3D=3D TAA_MITIGATION_OFF &&
>>> +=09    mds_mitigation =3D=3D MDS_MITIGATION_OFF)
>>>  =09=09goto out;
>>> =20
>>>  =09if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
>>> @@ -339,6 +343,15 @@ static void __init taa_select_mitigation(void)
>>>  =09if (taa_nosmt || cpu_mitigations_auto_nosmt())
>>>  =09=09cpu_smt_disable(false);
>>> =20
>>> +=09/*
>>> +=09 * Update MDS mitigation, if necessary, as the mds_user_clear is
>>> +=09 * now enabled for TAA mitigation.
>>> +=09 */
>>> +=09if (mds_mitigation =3D=3D MDS_MITIGATION_OFF &&
>>> +=09    boot_cpu_has_bug(X86_BUG_MDS)) {
>>> +=09=09mds_mitigation =3D MDS_MITIGATION_FULL;
>>> +=09=09mds_select_mitigation();
>> This will cause a confusing print in dmesg from previous and this call
>> to mds_select_mitigation().
>>
>> =09"MDS: Vulnerable"
>> =09"MDS: Mitigation: Clear CPU buffers"
>>
>> Maybe delay MDS mitigation print till TAA is evaluated.
> Since they're so intertwined it might make sense to just combine the two
> mitigations into a single function.
>
They are intertwined mainly for non-MDS_NO processors with TSX. The
mds_select_mitigation() function is pretty simple. Merging the two
together will make the MDS part harder to read. Also the pr_fmt() macro
has to be different for MDS and TAA.

Cheers,
Longman

