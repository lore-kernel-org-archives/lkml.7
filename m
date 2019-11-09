Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C8C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0865A214DB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFKpcy/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfKIB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:56:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39830 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKIB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:56:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so5098277plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=w85mDbrl98zC19IWsA33i23968j61ADtoHLnh8mee+M=;
        b=oFKpcy/IVgo0f5TIomYAcpSYOvIlYEOSfnVfbda16Uvv0OKwyjgnHd4wPU7DMkoA5W
         iXrE5w4uzB758lJFviiEHZLj3nChQ6+ssBQrGHSfx07A8GHzzC1i7zOgKMwlm++nU8vL
         eVYkDhjrTVzUIEuIWuq8lFfwpsx+ULqv/c1I9eOPPP0woXA8tv0SwXhLM7Jol4IpRNs4
         5zasOOfX2DEkS2G9nyJt2UGriUDxIDz+2+5EVCN4o8B/HvIAJlWnLiLThgcveSFrIWxq
         lpkvx2WvCiEcD2RJRD7LIvlCthZYy/qrukBIywwJldLnBAb0ouNO+jluMwrqcsQnZCov
         MdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=w85mDbrl98zC19IWsA33i23968j61ADtoHLnh8mee+M=;
        b=A2juyM3c5lYqk0irqAwC6nCqVRmcHOkgcAGZn5YxDmmf/2yjQ4c3D5IBaxQYko+QG/
         J91kdSS/esv2m1jb0jkEVxcFxP6CkcT4Xwfth14i7mv4pvvwMYfR/Lf1sV2rQ74lJVX2
         1Yj2Iy1ZjF2anTG1TBMsur8pyRWjZW+8ICElpk8XWf8URcVpbj3+MngD3EBfA0sgzgba
         fu6nsJH0ge5Xp/4eEEXZkUfV2c/LJDVTZ2zkiwMwPdYAN93V3QRKtJGtrRTlVacnAVVU
         5lrfAHeq5Sdkk2Tcakw6W0MygLDYnUQvJj2gmTp7GrwYXpkFIset2Gc/hDAXDKkVRsaJ
         O1Qg==
X-Gm-Message-State: APjAAAW4+pFLCFJBN/MMNHxgjeslOArm5V5Igsdn+RarC+1ei1QdW+IC
        G1vyTv8qvAoqVR/sZ8O+nSU+wQoAwUE=
X-Google-Smtp-Source: APXvYqynXu+vskZmkbVp+4vKqGg7XL5vBOM3PwBtvayvv0muXv888Kscfk6aSoyCvhxZTkk+KqMynA==
X-Received: by 2002:a17:902:409:: with SMTP id 9mr14706156ple.25.1573264613817;
        Fri, 08 Nov 2019 17:56:53 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id b9sm9088133pfp.77.2019.11.08.17.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 17:56:52 -0800 (PST)
Subject: Re: [scsi] 9393c8de62: Initramfs_unpacking_failed
To:     Finn Thain <fthain@telegraphics.com.au>,
        kernel test robot <lkp@intel.com>
References: <20191108072255.GX29418@shao2-debian>
 <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <6ad8eeef-101e-58ba-734d-1725c998a909@gmail.com>
Date:   Sat, 9 Nov 2019 14:56:46 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Am 09.11.2019 um 13:29 schrieb Finn Thain:
>
>> ...
>> [    1.278970] Trying to unpack rootfs image as initramfs...
>> [    4.011404] Initramfs unpacking failed: broken padding
>
> Was this test failure unrelated to commit 9393c8de62?

Seems to be unrelated - a m68k kernel with that commit included, SCSI 
core included but low-level driver built as a module(*)  boots into the 
initramfs just fine.

(*) well-known emulator bug.

Cheers,

	Michael
