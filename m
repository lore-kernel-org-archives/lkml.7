Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7226FC43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490F9222DC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Wfm+A2UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKRWVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:21:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36325 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRWVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:21:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so8564345lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=k8tXvyojuzIpGqqZbdiFU+fQa+u+1+HqoxvD/bINmWw=;
        b=Wfm+A2UU5wPRDg1SMAD6R61AQ5XyyAcA+QYMX0gxvsq0xwoogOpUdq2vuhCw0RF1ms
         Vtl5xTF58LswzSMtdjNRgdKYQ5myagl5Cg+mpUKtsAbte6sm29VGozNtwra7ysUujc1r
         eRe34JI3RrFyEDetqkXzaGmAII12jYrHnsui/Z1jFpwPC7vmnb2Sd3gSD2Bi3gEFm/pE
         MehhKnZ6MbbGBxkdEjfJ9sAjoHmkQ/jOS1quGveC8iqwuxKdhl/mG72iXkCF0DlIv40M
         jrkTp7c0O6aZqQVPC+Pb7+bPI4ZwnNLd+ZGD6D8imsql97huDrYthu2GNcHYT/l0mY/f
         JbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=k8tXvyojuzIpGqqZbdiFU+fQa+u+1+HqoxvD/bINmWw=;
        b=hG3oTGRiAw8XecLrOy4re8x9jOa6QjGZfQzzBz//wk6SUuD6UrqbKVOZvn7zlfR2+O
         jQA+K+NRCx2A4Zs0E3mRj3UisY5WkXVj7ct2lPwthO/sU+OtwAc+3kNRL8CJdixQjHej
         RkPvsEfEfON/mzchR+LadJrbVE/dQ/Ixu5GBD4jjkj3CAWJXaH8UyjeuJD9BzCFSI8+F
         wbYOldcsZrd0j/7X2jBnQ18Qdg7yfNT+LNtNFcEfKGFvhNhPOoT+ERryzG/PPdDCC5l1
         R+ixOZmMvu6lZ8ZCwSI4N4lh1cKDJOF/MbA+Bnm6ax+NZO/Tm+A4ycHN49wfCDr0F7It
         8aNw==
X-Gm-Message-State: APjAAAXi3+V3/nmerMbcQ3cYJdKIblfUSQSk9OvYQREG1/yacEpYl1RG
        obVgOzfXQpnbEWrDbv5x70WTzQ==
X-Google-Smtp-Source: APXvYqwL5R10R+su55IxhTubpVHRH7aFTPubqpCMTaOUvrhsWiPM/PDB5XrJGcB4hWmko9SmRrYqLA==
X-Received: by 2002:a05:6512:49c:: with SMTP id v28mr1197714lfq.9.1574115694006;
        Mon, 18 Nov 2019 14:21:34 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m18sm9528509ljg.3.2019.11.18.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:21:33 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:21:20 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jonathan Toppins <jtoppins@redhat.com>
Cc:     netdev@vger.kernel.org, Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bnx2x: initialize ethtool info->fw_version
 before use
Message-ID: <20191118142120.2cec693d@cakuba.netronome.com>
In-Reply-To: <f40bcf8cd93677c12bca1f06e74385c9a5f49819.1574096873.git.jtoppins@redhat.com>
References: <f40bcf8cd93677c12bca1f06e74385c9a5f49819.1574096873.git.jtoppins@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 12:07:53 -0500, Jonathan Toppins wrote:
> If the info->fw_version has garbage in the buffer this can lead to a BUG()
> being generated in strlcat() due to the use of strlen(). Initialize the
> buffer before use.
> 
> The use of a systemtap script can demonstrate the problem by injecting
> garbage into fw_version:


> @@ -1111,6 +1111,8 @@ static void bnx2x_get_drvinfo(struct net_device *dev,
>  	int ext_dev_info_offset;
>  	u32 mbi;
>  
> +	info->fw_version[0] = 0;
> +
>  	strlcpy(info->driver, DRV_MODULE_NAME, sizeof(info->driver));
>  	strlcpy(info->version, DRV_MODULE_VERSION, sizeof(info->version));

I don't know systemtap, so it's very unclear what you're trying to fix
here. Setting random fields of info to 0 seems pointless as the entire
structure is zeroed before the call in ethtool_get_drvinfo().

Please explain.
