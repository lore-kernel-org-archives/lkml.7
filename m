Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1EBC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260962084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ms5K2o3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfGVP1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:27:03 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:44992 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfGVP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:27:02 -0400
Received: by mail-vk1-f172.google.com with SMTP id w186so7916519vkd.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fFSW3MtnFG1vgXzyH4/3x+0Vpm+vDrL59dvaPAFK60=;
        b=ms5K2o3zppDIp0xReLN5y/RFuJeMBDR+pjBlQ29CXXv61pzwrKI0eW92RJXuWDzW5u
         usuFdcGKBYnckjeAjl0w2/2BHHhxAyxO6lHGqM3g1c3Un2u7CHOZ0ymu6hW81n780gvp
         elXOYse/tJh8KnO2NPTVhD+A10nqSGeGggnPufaTyBSITyDNe8Rd8msToJumwhBCxVFn
         eXceMEb++YjYWripjjoeKfe7xvbXQ/06yA15bNgCrf1u8YgwgLZ4ORS4zjNmr+1o8UY0
         GolnqtYlgVj8EYxYUJ8Hdhm7HfRz62aAEQBzacd+Qg2+wXBkf9Hy2TOIIYRnqoW9EtAe
         RnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fFSW3MtnFG1vgXzyH4/3x+0Vpm+vDrL59dvaPAFK60=;
        b=Blq+fyBgMZzNZd+DtV8hAsRHTkEDlWL6ikKqghwO3sdf1K4yHn+AhgZ0qFk8S3bUxE
         N8p1P9k32EQiFzyRo5NbV2ZIgcQCoIuNwgEyb5F1OrkHVsMfjaIIjrmiKp6rdGBUjID0
         nN/55Qni+kQJllb7xjYTQfkFtL4czbAB7JyKQazVxfV+RZAkPc2doEgm9zIHU+x8/73t
         6oHiOS2UqLKYGC0QrfitqYvQ0jFItoRRkCGpS4KfGMeUv4haH53JmBHyiYBdr7z7ezh5
         u60KlOKUPrG/tvOtQx1xNIufTmN3kR9jgdKEceB1cW2BvN4Qb37w605YiMSmK2ee4yEn
         3Ewg==
X-Gm-Message-State: APjAAAUect3dZjuepU7ANBuSaAqBHHWuUdUTXLFBBvbzt+H2NU6eQJ4W
        HFBnXq1NrPKs/Vu/OpjbtLKr6/eUBJOpLw==
X-Google-Smtp-Source: APXvYqwKmXaXKwn648l2BX/4Vui36L8YiKHD/p8j6Drku1qUj6wXiQ/SJlOqZVMT03zl3PN7212BYA==
X-Received: by 2002:a1f:e586:: with SMTP id c128mr21069024vkh.44.1563809221452;
        Mon, 22 Jul 2019 08:27:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h61sm8519740uah.18.2019.07.22.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 08:27:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpaDM-0004pT-5F; Mon, 22 Jul 2019 12:27:00 -0300
Date:   Mon, 22 Jul 2019 12:27:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] Fix reference counting for rxe tasklets
Message-ID: <20190722152700.GE7607@ziepe.ca>
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-6-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722151426.5266-6-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 05:14:21PM +0200, Maksym Planeta wrote:
>  
>  int rxe_init_task(void *obj, struct rxe_task *task,
> -		  void *arg, int (*func)(void *), char *name)
> +		  struct rxe_qp *qp, int (*func)(void *), char *name)
>  {
>  	task->obj	= obj;
> -	task->arg	= arg;
> +	task->arg	= qp;
>  	task->func	= func;
>  	snprintf(task->name, sizeof(task->name), "%s", name);
>  	task->destroyed	= false;
>  
> +	rxe_add_ref(&qp->pelem);

Please put the kref incrs near the copy of the pointer. Those things
are logically related - copy the pointer, incr the kref.

Jason
