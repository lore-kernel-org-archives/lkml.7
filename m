Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69789C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456BE218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RsKHCYwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbfJIXKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:10:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42662 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbfJIXKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:10:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so3828464qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 16:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PnjQOHepBuv9rYKnDUFewaU2wDCjjihpShjTxB7TXsk=;
        b=RsKHCYwlEK2MnPGOLw3WfXus/DDmivqcNdxalAOy3hlZ/qAQSBLq1JTB/kxeHQl1W3
         fEwIP+vV4b7VINYF3fxCLVX+ZDMkWBpk33nzXxBQmUpj4mWuG2L1jy25vxDQhUPJNWnI
         OLb2oVqDMOyZgZQyDg6NrudDbB/NlkOEj+xKnjOlzXp1VGahGeHGqixJ8EuWEWwbe/id
         YlS1JRQZpPp/HilLmm9nFyT5AF3dNB/7dQo58dqWYl5hSu2X7bxBDOVqcajUu1Et5uAU
         UjiSceUeTP8BfdtMBu2nPvkOfXRv/+k5TJe551yvWspUt8b5fhRsLOf6cs+3Uwk4mvNl
         hK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PnjQOHepBuv9rYKnDUFewaU2wDCjjihpShjTxB7TXsk=;
        b=RgJzgGLm2G2aklQJ593AirpmhOEsRK+EIKidkUPq9zEcqeyjuyV4aMuuU2fmoR90P5
         VLeP4CtpShfglK0S5MIeSVMWOB7sAE7KhDLgDpD2brqtJQ4KqvAMt2mfy+10DuqegKfO
         fNyMHukS3z3AzM1QkFmZtr4Qs6uSJecCgXQ+i2gXZ30qSSEUm1zG9LVNK/t9QStkIL4L
         SfE+lJKdLqFJL9uoKpxg9nTwfBhpauqb2xO0sa4K7siPtRuVvU+WosoTeSndEp37SlxR
         6rbDhz4/0LC4s/UfhPOhKrNibeiYZItKk2AZZXU+iuCfhr9XGJlGJWI+f9Iv2JV49FoG
         xbYQ==
X-Gm-Message-State: APjAAAVy1GMun8I5fUG2s33chOw0xukG9etbJ5WzjmgrfNRG/k2Fc8tk
        DBkWL9wDnCT7sl8hny/aJvkSpQ==
X-Google-Smtp-Source: APXvYqzDsg7VvPjwvTLuHucNP0B1UJPXSz1g9Ec4z5pbH0OhF3aJ6PEN0n9s/5rnpedoNj2WEr1nyw==
X-Received: by 2002:a05:620a:1355:: with SMTP id c21mr6444676qkl.288.1570662632760;
        Wed, 09 Oct 2019 16:10:32 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m186sm1709799qkb.88.2019.10.09.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:10:32 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:10:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: fix length of PTP clock's name string
Message-ID: <20191009161018.3b4919cd@cakuba.netronome.com>
In-Reply-To: <20191007154306.95827-3-antonio.borneo@st.com>
References: <20191007154306.95827-1-antonio.borneo@st.com>
        <20191007154306.95827-3-antonio.borneo@st.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 17:43:04 +0200, Antonio Borneo wrote:
> The field "name" in struct ptp_clock_info has a fixed size of 16
> chars and is used as zero terminated string by clock_name_show()
> in drivers/ptp/ptp_sysfs.c
> The current initialization value requires 17 chars to fit also the
> null termination, and this causes overflow to the next bytes in
> the struct when the string is read as null terminated:
> 	hexdump -C /sys/class/ptp/ptp0/clock_name
> 	00000000  73 74 6d 6d 61 63 5f 70  74 70 5f 63 6c 6f 63 6b  |stmmac_ptp_clock|
> 	00000010  a0 ac b9 03 0a                                    |.....|
> where the extra 4 bytes (excluding the newline) after the string
> represent the integer 0x03b9aca0 = 62500000 assigned to the field
> "max_adj" that follows "name" in the same struct.
> 
> There is no strict requirement for the "name" content and in the
> comment in ptp_clock_kernel.h it's reported it should just be 'A
> short "friendly name" to identify the clock'.
> Replace it with "stmmac ptp".
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")

Applied to net, queued for stable.

For future submissions please indicate the target tree. Networking fixes
should go to the net tree and have [PATCH net] in the subject, while
normal patches such as new features and clean ups should be tagged as
[PATCH net-next].
