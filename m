Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA50DC46460
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DC926894
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfFCUIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:08:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55892 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:08:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id C311D20B7192; Mon,  3 Jun 2019 13:08:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id C005A300544F;
        Mon,  3 Jun 2019 13:08:45 -0700 (PDT)
Date:   Mon, 3 Jun 2019 13:08:45 -0700 (PDT)
From:   jaskarankhurana@linux.microsoft.com
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, gmazyland@gmail.com
cc:     agk@redhat.com, snitzer@redhat.com, dm-deval@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com
Subject: Re:[RFC 1/1] Add dm verity root hash pkcs7 sig validation.
In-Reply-To: <MN2PR21MB1200327819F4810E82AA6FF38A000@MN2PR21MB1200.namprd21.prod.outlook.com>
Message-ID: <alpine.LRH.2.21.1906031246001.64221@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <MN2PR21MB1200327819F4810E82AA6FF38A000@MN2PR21MB1200.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2019, Milan Broz wrote:
> On 20/05/2019 23:54, Jaskaran Khurana wrote:
>> Adds in-kernel pkcs7 signature checking for the roothash of
>> the dm-verity hash tree.
>>
>>
>> Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
>> specified for all dm verity volumes and verification must succeed prior
>> to creation of device mapper block device.
>
> I am not sure this is a good idea. If I understand it correctly, this will
> block creating another dm-verity mappings without PKCS7 signature, and these
> are used in many other environments and applications that could possibly
> run on that system later.
>
> (But I have no idea how to solve it better though :-)
>
> ...
>
>> +	/* Root hash signature is  a optional parameter*/
>> +	r = verity_verify_root_hash(root_hash_digest_to_validate,
>> +				    strlen(root_hash_digest_to_validate),
>> +				    verify_args.sig,
>> +				    verify_args.sig_size);
>> +	if (r < 0) {
>> +		ti->error = "Root hash verification failed";
>> +		goto bad;
>> +	}
>
> You are sending the PKCS7 signature as a (quite large) binary blob inside the mapping table.
>
> I am not sure if it is possible here (I guess so), but why not put this it kernel keyring
> and then just reference it from mapping table?
> (We use kernel keyring in libcryptsetup already for dm-crypt.)
>
> It will also solve an issue in userspace patch, when you are reading the signature
> file too late (devices can be suspended in that moment, so I would prefer to download
> sig file to keyring in advance, and then just reference it in mapping table).
>
> (I guess you will send merge request for veritysetup userspace part later.)

I have made the changes for passing the signature bytes using the keyring 
and I had sent an updated patch for the same last week. I have given a 
link to the veritysetup changes which I used to test this in the patch and I will 
cleanup and send those for review next.

Please take a look and provide code review feedback for the kernel 
changes.

>
> Milan
>
Regards,
Jaskaran
