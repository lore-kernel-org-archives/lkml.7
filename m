Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42618C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1206420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WW4c84Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfEMHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:46:10 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61270 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfEMHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:46:10 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190513074608epoutp01be03308a7b73e44843fbd077d300e071~eLm1LtPyN2755427554epoutp01U
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:46:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190513074608epoutp01be03308a7b73e44843fbd077d300e071~eLm1LtPyN2755427554epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557733568;
        bh=szTOp4qdFhF5LZJ70Oq3g8WGaUzNNw6KiVLFGlGom3M=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=WW4c84ZuJCYR1m8TXGRWyoh38AQR96nAbw6HAenGw/LRV9d4IIJ/EuyjyUC+IgGaa
         KOj5yHi8fFHh8//2ylk9nwhvMbnr88iLw/RgfWPnHmZ02AirDiRx3c/MvPkalP56Rr
         au/lk+DMcqa977FKUVtbcNTXafdFiCXGI8Bto9Dk=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190513074605epcas2p4594314afd8cddf9bf1dde4c608a5ce7a~eLmyib23C1624816248epcas2p4B;
        Mon, 13 May 2019 07:46:05 +0000 (GMT)
X-AuditID: b6c32a45-d5fff70000001063-8f-5cd920ba3383
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.D6.04195.AB029DC5; Mon, 13 May 2019 16:46:02 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
Reply-To: minwoo.im@samsung.com
From:   Minwoo Im <minwoo.im@samsung.com>
To:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minwoo Im <minwoo.im@samsung.com>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190513074601epcms2p12c0a32730a16be3b69b68e3c9d4d0b92@epcms2p1>
Date:   Mon, 13 May 2019 16:46:01 +0900
X-CMS-MailID: 20190513074601epcms2p12c0a32730a16be3b69b68e3c9d4d0b92
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0hTcRjG+Z9ztp25Fqdp9WZR60hJhbotZ6fIijQ7UMEgqDDLDnpw0m7t
        zEtBZdnVyDQockp2z7SbdtGmH3SZFM0ig5qRo0itZk3Mohtdth2lvv14eN/3eZ//hcRVjdJo
        Mtfi4O0WzkRLI4jbd2cxcS51d4bmR6mM8bceQMyflg4pc6nuHsYMXf9EML57nzHG/SmVeeqq
        kjLVF/pkzI+DCqb/YSvOXB0YJJYo2PLigIy94+yRsY999QR7tuU9xt44t5Nt7i6SsqU3axF7
        5PBtgh1umGqQp5sWGnkum7ereUuWNTvXkpNMr1idmZKpT9Jo47TzmXm02sKZ+WQ6daUhLi3X
        FNyVVudzprygZOAEgU5YtNBuzXPwaqNVcCTTvC3bZNNqbfECZxbyLDnxWVbzAq1Go9MHKzeZ
        jPeflSPbG3lhf28HUYROy0qQnAQqEZqf/8RKUASpopoQPPnciUoQSSqpcfCrKTJUE0mxEHjq
        wUOyipoG3/waUZ4FgWaPJMRSKhaKjvmJEEdRdQj8XUxoJE5dxqDrwbBE9FLCif19hMiTofHi
        LRRiOZUG3sZDI/p46K77KBvlwY5qJHIU7PV14iKPg1ffm8NrAgXgCywScSfcrAnbArUHgffD
        lZHWBNj1dig8Xkmtgt3XDmEhJqgZ0OYqG6lJhcFdbWFbPBix8WNVOC4ezHjNlSCOj4H2F4RY
        MRYO3P0lGw3VdLIXEzkGhtzukSUnwcWuAanYykJl2TrxjB8geO96JylDaue/Y3b+5+v853sK
        4bVoAm8TzDm8oLNp/7/ZBhR+tLOXNaETj1a6EUUieoySeuvNUEm4fGGr2Y2AxOkoZfr0oKTM
        5rZu4+3WTHueiRfcSB+MX45Hj8+yBr+AxZGp1euSkjTz9Yw+ScfQE5U3FN0ZKiqHc/Cbed7G
        20f7MFIeXYQGooufT3nC/gmk5S8B37v+esXvgnlrH3ngqNygS2nB+l4W3jopPS+0Gzw7hpe3
        HTkjnE08/nNmRUHsHJtx2ZeNE3oUhhr94fU9ERva53rHOLmCPZV9hZ3FNV8lr7dXb/F7l3Zc
        UDQY7KXJB9Uxa1Zvvh/fWRJb8W2xBl+R0lq+z0MTgpHTzsbtAvcXmrYWDMoDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190512155540epcas4p14c15eb86b08dcd281e9a93a4fc190800
References: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
        <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
        <CGME20190512155540epcas4p14c15eb86b08dcd281e9a93a4fc190800@epcms2p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void *buf,
> +					 size_t bytes, loff_t offset)
> +{
> +	loff_t pos = 0;
> +	u32 chunk_size;
> +
> +	if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))
> +		chunk_size = UINT_MAX;
> +
> +	while (pos < bytes) {
> +		size_t size = min_t(size_t, bytes - pos, chunk_size);
> +		int ret;
> +
> +		ret = nvme_get_log(ctrl, NVME_NSID_ALL,
> NVME_LOG_TELEMETRY_CTRL,
> +				   0, buf + pos, size, offset + pos);
> +		if (ret)
> +			return ret;
> +
> +		pos += size;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nvme_get_telemetry_log(struct nvme_ctrl *ctrl,
> +				  struct sg_table *table, size_t bytes)
> +{
> +	int n = sg_nents(table->sgl);
> +	struct scatterlist *sg;
> +	size_t offset = 0;
> +	int i;
> +
> +	for_each_sg(table->sgl, sg, n, i) {
> +		struct page *page = sg_page(sg);
> +		size_t size = min_t(int, bytes - offset, sg->length);
> +		int ret;
> +
> +		ret = nvme_get_telemetry_log_blocks(ctrl,
> page_address(page),
> +						    size, offset);
> +		if (ret)
> +			return ret;
> +
> +		offset += size;
> +	}
> +
> +	return 0;
> +}

Can we have those two in nvme-core module instead of being in pci module?
