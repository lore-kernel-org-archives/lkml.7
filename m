Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95DB2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX5Dcqig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfGQLyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 07:54:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 07:54:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so11868576pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftsA6SziUzB7mZMqtb+NPTOifNieeCki+4HWoD26B1Y=;
        b=RX5DcqigpBS6JXUlYNzu9cmNMAC2grNOXp9WsR0aK0MCsioAXFeMRSMQHJR2oP1DOv
         uTQp8odiUnxv/zpgKZZn/q9NJ/sGzWV3xfils+WM1YL69MBfwixBwgD5PQl6G+DEDe9p
         AfLe1ruR/2eWKLQBC8yp5Y8mQ5//Z0Cz9PAjMzaXclRWCXSxAKI0xugHegeT/bJ5DFXT
         83h5pYuhgK9CBpf+24Qr3WIsTvlaPdSR84jq7tYki4PP8woT1zPumXvGelaTRPWM6CRJ
         aXeFOZKK+gKOnX7gpveGdh00ggAnBKZqVirZmWkPpls9LytJZ4yFtoNnohPTOHgNMMnv
         9msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftsA6SziUzB7mZMqtb+NPTOifNieeCki+4HWoD26B1Y=;
        b=pLgOqFlIoCU2QsyCZYy1Mbikc0rXzwLv5ZCt+hQnC9dMwIflDE8bTHwvfotWQG2xaF
         AOlmUHMsjCj2pG9zFu+1K10y74Z8Nv7J7he2TjKvkGZ7oRc0lapMws65zuabv8xkNoyQ
         RoQvLqEyzc5hYWbj96NiqWlTrYbdM1f63D20uSt09wscBv4qVwAMeSuQEmSJRDv+gUJb
         xlEHzF9yof3eEhD8OK5rhhHoHq3/s/KwD7Z5Om5mP28YKqNHAcbQnSmGc4tKdQUsIXja
         teiNrddfxRm1affxH2GVXDHurVcg4/rxMa2aHSAwFcRp/HZXdlnxPWsHWvI6mkWxneff
         mOrA==
X-Gm-Message-State: APjAAAVAnviKfk5ocTCFvCpbHyWf3q8I3jI0z+piHOuQfJmvVUA8wf0I
        WT31KcX5GjykbhhceOMDTm4fFVdQfaw=
X-Google-Smtp-Source: APXvYqzO02oaG99jKfNVRblZVE5ffaRzjKmORg3MYGOu0u9fYxYJwDy/w8tVgyvu/Y2NMOte7qvNvw==
X-Received: by 2002:a17:902:ea:: with SMTP id a97mr42227799pla.182.1563364472811;
        Wed, 17 Jul 2019 04:54:32 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id k8sm24242905pgm.14.2019.07.17.04.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:54:32 -0700 (PDT)
Date:   Wed, 17 Jul 2019 20:54:29 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v2 3/3] nvme-pci: Add support for Apple 2018+ models
Message-ID: <20190717115429.GC10495@minwoo-desktop>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
 <20190717004527.30363-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190717004527.30363-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-17 10:45:27, Benjamin Herrenschmidt wrote:
> Based on reverse engineering and original patch by
> 
> Paul Pawlowski <paul@mrarm.io>
> 
> This adds support for Apple weird implementation of NVME in their
> 2018 or later machines. It accounts for the twice-as-big SQ entries
> for the IO queues, and the fact that only interrupt vector 0 appears
> to function properly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> # Conflicts:
> #	drivers/nvme/host/core.c
> ---
>  drivers/nvme/host/nvme.h | 10 ++++++++++
>  drivers/nvme/host/pci.c  | 21 ++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 716a876119c8..ced0e0a7e039 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -92,6 +92,16 @@ enum nvme_quirks {
>  	 * Broken Write Zeroes.
>  	 */
>  	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
> +
> +	/*
> +	 * Use only one interrupt vector for all queues
> +	 */
> +	NVME_QUIRK_SINGLE_VECTOR		= (1 << 10),
> +
> +	/*
> +	 * Use non-standard 128 bytes SQEs.
> +	 */
> +	NVME_QUIRK_128_BYTES_SQES		= (1 << 11),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1637677afb78..7088971d4c42 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2081,6 +2081,13 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
>  	dev->io_queues[HCTX_TYPE_READ] = 0;
>  
> +	/*
> +	 * Some Apple controllers require all queues to use the
> +	 * first vector.
> +	 */
> +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> +		irq_queues = 1;
> +
>  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
>  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>  }
> @@ -2322,7 +2329,16 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  				io_queue_depth);
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  	dev->dbs = dev->bar + 4096;
> -	dev->io_sqes = NVME_NVM_IOSQES;
> +
> +	/*
> +	 * Some Apple controllers require a non-standard SQE size.
> +	 * Interestingly they also seem to ignore the CC:IOSQES register
> +	 * so we don't bother updating it here.
> +	 */

That is really interesting.

This also looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,
