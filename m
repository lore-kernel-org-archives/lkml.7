Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F31C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91D726D62
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="lE/gBTu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFCSb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:31:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38282 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfFCSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:31:56 -0400
Received: by mail-oi1-f194.google.com with SMTP id 18so12833746oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JB7G7a3obPccO07RyvNY8mElks92DaU5NY5QKwWTZvQ=;
        b=lE/gBTu5gNk+nG3gMkLC5L1qqMeFZke1tNjNI5xgMMMUPlBG3ZAzppxMiEuBOtKiMI
         Y6xOk9eUEgPGAqGCVGFZpHU68PsLFNawXTBrG55HWus8sEfa/pbs2FkPH3l9y2eEvDvI
         iGvFo6MBYyAPDhEBFQ/4NNauvhmdicFzBSZLXBRHikKFhbpLDxXobG2dm7zdUMcMLlR4
         bLxdEBF7g9pTfKNAUVZBPWJPnMha7n3pUfVeRzY2e9a5BSDSaj0E6B5Lem8uEQQeVdh+
         wXJNvLH9D4lzgEpF3Pu7V+6V4lfAyFJbr7/0knZSFvSon08cblLXIUE+SrdvBuzGJp3y
         AyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JB7G7a3obPccO07RyvNY8mElks92DaU5NY5QKwWTZvQ=;
        b=POs0rh96i+0G8LLMktYV9Y5EaRw01HRZ8LmmDlLJ2wz3c2x4eP9VNJddl/bp0/OJtw
         2U7w2ERFwJxhoHELRiNn2+iUDlU5C6LzlMANM7IX+U3Qa5SI/ML3nRpG7p9NEzJDIqeG
         lTWn0tRdL8xyFfu074T6ufhDWsbklqsCdnDIeMqMunkAJCcnUYL1Tn12I/M9JAH30aw3
         lR1qPNNpdLm12XG2D6QN542UFCaj9d2dCGDmMyMaPvSJF/XH29+KzccckkEXl9odrfYP
         4TfQDSPHGTb8Iu71pvZnQTDq7vqsfDDEV0ov6dFbYgZgyclVImhKiW1Oe13JAEazTMat
         MOxQ==
X-Gm-Message-State: APjAAAVSCWCBQZAn8/VzX/GHcZhFhdw3V6ddfhFU9htRAeLjbcNErKCp
        2LwC7i8kcpZ8m02+N/AHBCyPQQ==
X-Google-Smtp-Source: APXvYqx/JQHKW1RVtJywUChZiZhbYIWjyWjyP52wifJ5hVzfHkQZ9dKculi7hqOvLpAffmvtGewfWA==
X-Received: by 2002:aca:c382:: with SMTP id t124mr1900442oif.9.1559586715364;
        Mon, 03 Jun 2019 11:31:55 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id b127sm6172046oih.43.2019.06.03.11.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:31:54 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-cpio@gnu.org,
        zohar@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com,
        dmitry.kasatkin@huawei.com, takondra@cisco.com, kamensky@cisco.com,
        hpa@zytor.com, arnd@arndb.de, james.w.mcmechan@gmail.com,
        niveditas98@gmail.com
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
 <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <541e9ea1-024f-5c22-0b58-f8692e6c1eb1@landley.net>
Date:   Mon, 3 Jun 2019 13:32:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf9d08ca-74c7-c945-5bf9-7c3495907d1e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 4:31 AM, Roberto Sassu wrote:
>> This patch set aims at solving the following use case: appraise files from
>> the initial ram disk. To do that, IMA checks the signature/hash from the
>> security.ima xattr. Unfortunately, this use case cannot be implemented
>> currently, as the CPIO format does not support xattrs.
>>
>> This proposal consists in including file metadata as additional files named
>> METADATA!!!, for each file added to the ram disk. The CPIO parser in the
>> kernel recognizes these special files from the file name, and calls the
>> appropriate parser to add metadata to the previously extracted file. It has
>> been proposed to use bit 17:16 of the file mode as a way to recognize files
>> with metadata, but both the kernel and the cpio tool declare the file mode
>> as unsigned short.
>
> Any opinion on this patch set?
> 
> Thanks
> 
> Roberto

Sorry, I've had the window open since you posted it but haven't gotten around to
it. I'll try to build it later today.

It does look interesting, and I have no objections to the basic approach. I
should be able to add support to toybox cpio over a weekend once I've got the
kernel doing it to test against.

Rob
