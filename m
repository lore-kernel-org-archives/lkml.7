Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CFAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7E5217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 01:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="kUQMMuXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfIUB7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 21:59:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38555 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404899AbfIUB7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 21:59:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id u186so9272306qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=K0xV+Q/+lH76qOTLHDeb3Rh6Bv6ZBT2WraMP2UWkKjo=;
        b=kUQMMuXZKtVLWjQKUDQyrAgbpeaceIA2XHUy6ZVa7euUj6gsHX7ejCXN1o5KhlEC1A
         n9RgkwV5q6GBbqTktGELZT4rqF4ta0V87SpGEOhE87LFAy6xJa23LYNqwhPGFusvoTZy
         7LbfRvKH9XX3VsE5OebA1n/TP1v3Exnb79JTXEcL6HQNgZ7Y8DAeqDs5NIig/ifoRmWA
         YvvJ+fQ/smPo9ehuAVdoJkXID6d1AWQRdQ8DTnvj2dtaRJVuyCvRE2f9H7ykzsheISxe
         ZchxaBNF/R8FLjKAvkwL2YbOCVgHnDRfVBOxFpCi+aPETJwHn6+BUqqpuiUW+qvmbtOl
         cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=K0xV+Q/+lH76qOTLHDeb3Rh6Bv6ZBT2WraMP2UWkKjo=;
        b=nMN07oIKT3mgysRzPjiqvKMJJ5+PqHuL/+SeVzo3EmJ1UaP2ccKrvrnzYOHZbxdqWG
         lxrI/okTeLLQvx/z8ucFFVnT0wQAFinm6hR1XImuP7aMCWvJ6fMAYMgGKXSrfFXH5Uex
         Nu3EmlyUrU4sxGC12eY3YtygpDV4JWsSnEH8X4PxopJItuCq30hpG3XEVkm21hHi3WTs
         8LFGZXdzsVjTCZq1VOxsvyd2wClQnPR+rZWHeQFPWqDZpBH7bp4YSJTN4XusOdKd9fBE
         ZoI/QJ6R/oXOrSUcwhJ4jyfXl/7Mooy+m76d8N3fLtm9F1ltkJ48GraofGZoXAMGxp8q
         ROVA==
X-Gm-Message-State: APjAAAW1AXLSacg0+9lW5TjfLKWLfDVEsun2rGUMlAZyzC18hVUqkz+K
        dyqni8RPo8JlVSV+LFfFSQrBn9mW5HE=
X-Google-Smtp-Source: APXvYqzjGPQtE8Y6sHZG9JaqI1r/KJoOZFrWFWqe4IGv9iu7j2P2VgCYm0PYtma5uli6Vxi6rkdlAw==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr6729022qkh.157.1569031143058;
        Fri, 20 Sep 2019 18:59:03 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w131sm2150108qka.85.2019.09.20.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 18:59:02 -0700 (PDT)
Date:   Fri, 20 Sep 2019 18:58:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: remove un-implemented property
Message-ID: <20190920185859.6ebf05f1@cakuba.netronome.com>
In-Reply-To: <20190918111447.3084-1-alexandru.ardelean@analog.com>
References: <20190918111447.3084-1-alexandru.ardelean@analog.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 14:14:47 +0300, Alexandru Ardelean wrote:
> The `adi,disable-energy-detect` property was implemented in an initial
> version of the `adin` driver series, but after a review it was discarded in
> favor of implementing the ETHTOOL_PHY_EDPD phy-tunable option.
> 
> With the ETHTOOL_PHY_EDPD control, it's possible to disable/enable
> Energy-Detect-Power-Down for the `adin` PHY, so this device-tree is not
> needed.
> 
> Fixes: 767078132ff9 ("dt-bindings: net: add bindings for ADIN PHY driver")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied, thank you!
