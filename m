Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6438FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336DD20866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 20:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YTiWrOb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgACUX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 15:23:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45162 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgACUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 15:23:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so37680816qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Eh1yQkvu28vzyYRDiVcQwSW+SUklb8lMZ4DpMKEnY4=;
        b=YTiWrOb56a1ZHIaSf9O1wVNbS19lXhKtyLknLuzFJx77TN9chzR0h/NE0jPdefQVKN
         YlDU+Z6Z1GO5iLxvZenhQO/P1FszjgWeD+IeraEzD38TNudMORVNtJDUz4eL+ILvOOZt
         /sTzBavh0R4suV3EcHnPQAj0BTBZ6aKNK+A48gwqPlbK6X2PHv1qjQSYQnnX91TnF4jk
         7B+Fo2XNfybeccmk9/U+j53rZjHC/ZTbes07YToLu+tHhLpG6roLycovloDH0klYvpvl
         a96tuQL+sP3DDA/f0kwXdsqelAsLzsUYlkrcvGtBPtCn5gs/MKnRtzDSDN+eySr3sVu9
         p3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Eh1yQkvu28vzyYRDiVcQwSW+SUklb8lMZ4DpMKEnY4=;
        b=jsYTrDO5o3iYrgz+280086pE9xfvfiqcQmN4JW7O0G32DMDfoTgoyLWq8HmlcqQlno
         Cf3m13wSVgPQLDLtoL73Vz4O5q1CdgQESP5txCQPOLN9oElRn5gOyf3bM5+38HqDDnca
         kMcNnHoFbgNz9IYUlXDWtuyIB6S930ykAC/eGDjxfQJJY/HBHOEiwPay2aVmq8Qm6lqP
         mtdaOAaQCWMPE2v1gvOMAtVhBVlndLuUbJ7+deP6hLO6fGdAv+87Rw1F75uN+OLPnSlZ
         E23LIaMv5R2r6NVf2xJS2VDKSU6QqH7Zoz5oc73vCoCI4Mg5FjsJm1xKj39J1X+1m7HL
         V8Dw==
X-Gm-Message-State: APjAAAXCr1asC/GSvQClOChs6it8kg6NMl9M99/Z3lTpNOujQHJ2xqAx
        RRzzSAr9WrnqQTeELedgILoe4Q==
X-Google-Smtp-Source: APXvYqxy1Faz1t5NblybFE11de0p8ag9hlUiNxnTiTsaHJhdsIDTGMwllYn8llwMRaRMp/npH4bmGw==
X-Received: by 2002:ac8:1aeb:: with SMTP id h40mr66103001qtk.269.1578083004353;
        Fri, 03 Jan 2020 12:23:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d143sm16960386qke.123.2020.01.03.12.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:23:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inTTf-00043e-Dx; Fri, 03 Jan 2020 16:23:23 -0400
Date:   Fri, 3 Jan 2020 16:23:23 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: RDMA/srpt: remove unnecessary assertion in
 srpt_queue_response
Message-ID: <20200103202323.GA15557@ziepe.ca>
References: <20191217194437.25568-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217194437.25568-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:44:37PM -0600, Aditya Pakki wrote:
> Currently, BUG_ON in srpt_queue_response, is used as an assertion for
> empty rdma channel. However, if the channel is NULL, the call trace
> on console is sufficient for diagnosis.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
> v1: Avoid potential NULL pointer derefernce of ch. Current fix
> suggested by Bart Van Assche
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next with the reworked commit message Bart suggested

Thanks,
Jason
