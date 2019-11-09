Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C6C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0F121019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 01:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS0lPkwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfKIBYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 20:24:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44241 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfKIBYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 20:24:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id f19so5248860pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 17:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tHg75q28cW6kYk31ljnkA7mCb7G4nsjc/nizcLVYO0U=;
        b=WS0lPkwMAqE2VavIJ8d99wtfYML2qv48QY2pzJL5Sd2AkXAN3v5Oqkt6dkVtFmIuB3
         vjVLaR+0DBWkxGWdamo15RsIBcmMQjMVD+iG4zPxY2eN/m8rtTNgx9SA4yODn0kfTJA8
         Sk0f/o3+38e0ZC1JwOG/JKX88Of+kkV9ERROUX4xzyFI0o91fFm1OwuAhn8M6E+9DtCc
         knLIszX3hv0TvUn6ETvO3mtu90vQzphJyPQxpgC8S8A/bfd2BJKQnLLYn/UOzYV1u7y6
         d8r136e/vX2Q637NrHn+BF88w9Wni3klJIARhHmSouyd32IJyYqsw3Ju9e94UuFEsjwe
         v+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tHg75q28cW6kYk31ljnkA7mCb7G4nsjc/nizcLVYO0U=;
        b=Ej05ew2ausAGVzdgF/F/koFewzVXVXdZmvbRjM/aPRzB/2RTewl784zPuVDZfh0HV8
         OHJtKoHbPA5kTJTbwIZ4nMag/4nrCTFARA3LKo5n0Jr6Td0ng6jNOKziLUv9sCGhwpVJ
         u6Vv1415HR7doMLGuC5KGv6+cSXtb6S7viV+65vbTejG7cUmhdfzAub0at5AwPrmtNPQ
         WVaL4aTzIratMtlKk+BSkl0ysabvXxN7JbyZglOIPk/97JVvLXjJQkXOB+lWMP69zxa1
         5FR5S4FkGjul8jzyFxjoXrtijKJ/a4nYtPaw5DPCoq1b3vNWzUIIBI2oqelVi+YZUlPQ
         u+0w==
X-Gm-Message-State: APjAAAVk4lwHcirwP+fLicjqlhmPUbQB8cV51BUQCSb+peW16TPb7A4N
        20jOBRneD0/cvF5udpnrHAA=
X-Google-Smtp-Source: APXvYqzGKS1AzE6SzJs5+qhek3sxZHNuAs24Qnswge/l4XRHSivNbq2T7YbbgsU9Kgf5WzrY4GWUig==
X-Received: by 2002:a63:8c07:: with SMTP id m7mr15763258pgd.317.1573262681665;
        Fri, 08 Nov 2019 17:24:41 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id g6sm6928855pfh.125.2019.11.08.17.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 17:24:41 -0800 (PST)
Subject: Re: [scsi] 9393c8de62: Initramfs_unpacking_failed
To:     Finn Thain <fthain@telegraphics.com.au>,
        kernel test robot <lkp@intel.com>
References: <20191108072255.GX29418@shao2-debian>
 <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <879035da-8316-ab21-f3fe-c4c6736ccbe6@gmail.com>
Date:   Sat, 9 Nov 2019 14:24:35 +1300
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

I wonder - the SCSI core was initialized before that log excerpt. I just 
can't see how unpacking an initramfs would involve SCSI core functions.

Will try to reproduce this using a different emulator.

Cheers,

	Michael


