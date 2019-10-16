Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E5ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFE2207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="SeWXto8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbfJPCGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:06:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:06:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so5934294pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUyOL2RIItCROatK1a3xuyc4JsvfPMONoizipcHDbl0=;
        b=SeWXto8TKxbAR5Gk7e3/sNJ93alMjzCClvODSG30bXgpV//NkHjE/CrxFes/2PuIrm
         1ZaQoszX9l1cAIP0YZMAAg5IL5/aO/IYZYBwvSGvB8Ed7iN6v4mpuy8jvNosThAVKik3
         xrlKdq3W/y91a7mk7btm2RdUK9Kj2pweOZnt0KNfktRKvuLLPpuoffdYEqWQeTXFeM9H
         XRe11OkLfpHKgnnaJeIiX4MRA3hTvwECaamHV2EBqsDpjsDtYmdpTaf/mgzaAwlX8mhV
         GDnn7eaZ8tFe2FaLPpRBUYzBxEiSvp7VWuxu1IsKoiM5LJUYQLwaUNzAhg14u1/Uutok
         niFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUyOL2RIItCROatK1a3xuyc4JsvfPMONoizipcHDbl0=;
        b=SWqHGgUAeCHmO8l/LCzJWnUjVLi2QszOVIELhojSxFnWZKXZPoG5qqA9LiBKQhx+2E
         xhpmH9YT/TJtSTMXW7zxfyCB11Nep3sdC1lClb7JV7rnKTYbVQPIQgiFYAeGxRrwSnaX
         1LvizKZ2WeTHRIX8ekJg8hXwtV/bQt2GWvv5i7ZQdrW+7ePBavuhV7Sx3R4btKJf3+Q9
         gQ6ukD6NvvraDxTLOdoeooIIVpNx1lwLKMqDJyYtjf8Cezl93txrPBnvmzHbtR4YYpKt
         iGjmUs4x2xQe0mfDp7ciUTgwX4PAkJ6LEZZhfddVst70iJOA/g1yN71rUVzK+vrQ1zOK
         zQJw==
X-Gm-Message-State: APjAAAUEjpyvamOjeOCqIEcxKJn1Gt3+/O1Ore8Q5H0ZAuYES6ol5STb
        He5FVx0BSob2pxBYY8QQH6xiKA==
X-Google-Smtp-Source: APXvYqwkwJFDGyB+giPsa2PBmCrDHadkgO1bXhA+XZVLm8X0qvRt1WvbEfJ3lNRuqHDVSPo85pGEQg==
X-Received: by 2002:a17:90a:ff0f:: with SMTP id ce15mr1971060pjb.14.1571191611965;
        Tue, 15 Oct 2019 19:06:51 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id e16sm11583122pgt.68.2019.10.15.19.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 19:06:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 19:06:49 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com, tiwei.bie@intel.com,
        jason.zeng@intel.com, zhiyuan.lv@intel.com
Subject: Re: [RFC 1/2] vhost: IFC VF hardware operation layer
Message-ID: <20191015190649.54ddc91c@hermes.lan>
In-Reply-To: <20191016010318.3199-2-lingshan.zhu@intel.com>
References: <20191016010318.3199-1-lingshan.zhu@intel.com>
        <20191016010318.3199-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 09:03:17 +0800
Zhu Lingshan <lingshan.zhu@intel.com> wrote:

> +	IFC_INFO(&dev->dev, "PCI capability mapping:\n"
> +				"common cfg: %p\n"
> +				"notify base: %p\n"
> +				"isr cfg: %p\n"
> +				"device cfg: %p\n"
> +				"multiplier: %u\n",
> +				hw->common_cfg,
> +				hw->notify_base,
> +				hw->isr,
> +				hw->dev_cfg,
> +				hw->notify_off_multiplier);

Since kernel messages go to syslog, syslog does not handle multi-line
messages very well. This should be a single line.

Also, this is the kind of message that should be at the debug
level; something that is useful to the driver developers
but not something that needs to be filling up every end users log.
