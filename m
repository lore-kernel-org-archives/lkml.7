Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820052086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="BJHxrU1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfJCVbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:31:46 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46991 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJCVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:31:46 -0400
Received: by mail-qt1-f180.google.com with SMTP id u22so5687758qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9VbPegMBaauhbhqrGeSKBEluFIPdq7CVXWZA4Bamei8=;
        b=BJHxrU1nSyyy8QF2YqhUZ6bw3iyG47Xae1aeOT1UUoyKSErx+TwdcWv7QJp3ii6FUC
         GrjZy9eSgAQQGYaRMZIPwTn5cnnCQZ0/M0OP9SOTuR7wGkcNI5MnFo6SbIPzPqFBM+t1
         lht3nPaJTvInTyk/eyJtUVjt5laQLj3IrPzy+Wn8omLAEUzIzjctOIXl1C4uD+1PWhJS
         CUe5uYo+RDEvTQirTAL6mEV7MtPuMLpziS85bx2PyX+09SgwivFMzbKT/wCFocIoDA8v
         sV6aUGef1efw+0+SPYN7HsHKFTHwjWxeUpls4Rd2dgFQvhv0/k0+An4AE3up6lsiDm3A
         DGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9VbPegMBaauhbhqrGeSKBEluFIPdq7CVXWZA4Bamei8=;
        b=oSJWXZBJsZFWPhVfJ7uaglkbIrTJrQOCzy80Rj6iOio1xxa+rv+Yx+wx/q/AajBgAM
         Vm+usVWOg7AC54WBM9PGvoQdDzMduowRY0l+EIb1UAffsVR4SFEeDWfZCNLtKWRdi5x6
         FqdXB4AedEPtCC0h54ygQcZbZqotZYMpfVYwe8BV1xVrklO9aJmQEsqbaVzNhNTR+9vi
         TQOG4bvoG1i66uV7vgprmMU1LlaqSXYtaMfw9E0uspt8knjOzbwyNIPs8oFNe0PVIQoH
         Xfp4S0FAC0dc7mZlOOKuIZtq7fjkOH6/bvbORxhQeBiH+RPAEtsS7iP1US98WJAS4O4W
         uezg==
X-Gm-Message-State: APjAAAXr2+5KI0mL9fzQToi/EXFgbqfAzCDSLXSknXiYuXcGT8PUpEbF
        CS9obmYqiArNTSnmLyyix/qHajv2TLTxyw==
X-Google-Smtp-Source: APXvYqwgx7GCDCzm1ugkjBJk7NQzk6WWoKpRMlg4DROZvf+75wqqSA3Qq5BDTpkQ3s3fOr1cp8IFDg==
X-Received: by 2002:ad4:4772:: with SMTP id d18mr10824473qvx.100.1570138304941;
        Thu, 03 Oct 2019 14:31:44 -0700 (PDT)
Received: from tonnant.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id q5sm2820352qte.38.2019.10.03.14.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 14:31:44 -0700 (PDT)
From:   Jon Masters <jcm@jonmasters.org>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190910042107.GA1517@darwi-home-pc>
Message-ID: <cbcfca99-5c84-bab5-3b50-448e048bd2e9@jonmasters.org>
Date:   Thu, 3 Oct 2019 17:31:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190910042107.GA1517@darwi-home-pc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/19 12:21 AM, Ahmed S. Darwish wrote:

> Can this even be considered a user-space breakage? I'm honestly not
> sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> early-on fixes the problem. I'm not sure about the status of older
> CPUs though.

Tangent: I asked aloud on Twitter last night if anyone had exploited
Rowhammer-like effects to generate entropy...and sure enough, the usual
suspects have: https://arxiv.org/pdf/1808.04286.pdf

While this requires low level access to a memory controller, it's
perhaps an example of something a platform designer could look at as a
source to introduce boot-time entropy for e.g. EFI_RNG_PROTOCOL even on
an existing platform without dedicated hardware for the purpose.

Just a thought.

Jon.
