Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3554ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979F020872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="1w0IOtYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfJPCFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:05:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37145 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfJPCFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:05:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so13675195pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QC3gEZR1hPeoV9cErrVTRBwhQgxMJw1kOt/RcyP6C6w=;
        b=1w0IOtYfvSoz2t35HiCfmWEBG/6NZWQDRGyT9mxsztX6Py9Chwl0498ydNjJh0c//p
         /pUv8LxQNVibIrycGvKocjulsnsWN/vrTMaIcY1fIUvc31ZU4qCJbyuLdDBntXMOE97d
         CyZP6VcCp7aR21Vyf109i5U2fhry6UYaMZg/lPZnzoxThrZk2aILiB6YLGoeDlXfwUCp
         WZ55aOfZvtWNYwrk3OErtEE+rJS+BVioCM6nZOf2QnanyzFj9ftGRv/hZAkzpU6ZzsaG
         hnJoKhQL2U4Vq2icAfQqb45uaJqw1uM7uoNVkHL4LUEWI48WHdO77tRksqhZaU97DX4U
         8dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QC3gEZR1hPeoV9cErrVTRBwhQgxMJw1kOt/RcyP6C6w=;
        b=sCh7mD5y+yXNBpsydq3sm83qyoVxaa+U8lmehKwyTyNA9xfoggRrKDdnvyV4/XqPlq
         kyIt49966pihPJyqpqd6xI1YfkQ46RZy1G8TDpA8yzcQb0rkLo8XAEmY9tSAGwA4sX3m
         XqHx2s+KVFfQB/TS4PzJkUO5OzFeBMiF2hBEf4n47dXzRuJ8qHZv0teFm+B5ZRAqp/D4
         uB4bWiMvhwZPL3WSbe/+2JxSSeUIAOwvjy9KuT8Pd9U3pBCb5nY5YnDMDVoSQpXkge5L
         q1RVczfvmIvNMEolrkeIlfKLQCbtQ2KJgb0lYwxLItZ+xxWqT1mM7IVvN10C1WaIpVEw
         qeiw==
X-Gm-Message-State: APjAAAXfGZ+56Z4/i25Irv0Ziq78s6jN1/I9jAxIN7CtRJ7GBh5cjYqq
        AL9/yPyM5E5QeT92N/Vz/Av9mw==
X-Google-Smtp-Source: APXvYqw/EikbC+SU1Dgo4BMgqr5G5Xrl3P4spbJU2PEsTCnZX+e9JRuffgAYMJbGXbmsMOTX3yMNyA==
X-Received: by 2002:a63:3c3:: with SMTP id 186mr22567709pgd.285.1571191502725;
        Tue, 15 Oct 2019 19:05:02 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 16sm21264196pfn.35.2019.10.15.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 19:05:02 -0700 (PDT)
Date:   Tue, 15 Oct 2019 19:04:55 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        dan.daly@intel.com, cunming.liang@intel.com, tiwei.bie@intel.com,
        jason.zeng@intel.com, zhiyuan.lv@intel.com
Subject: Re: [RFC 1/2] vhost: IFC VF hardware operation layer
Message-ID: <20191015190455.0d79b836@hermes.lan>
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

> +int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *dev)
> +{
> +	int ret;
> +	u8 pos;
> +	struct virtio_pci_cap cap;
> +	u32 i;
> +	u16 notify_off;

For network code, the preferred declaration style is
reverse christmas tree.
