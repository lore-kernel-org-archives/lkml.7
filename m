Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453FCC32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B41C20866
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JycquDxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgADABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:01:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46506 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgADABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:01:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so35075977qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FyxITQ06mRJ5LXE0g6/PDzDBVCahITkTQdAtCtjXbRA=;
        b=JycquDxZmpvNSLHrC0gLJNcNVObsJLFaFftFQXWXhrPcDE6GUzXJg7aRUccY/JakTP
         4Q+idNLtoSxJR8CzhGXwvj5DkdWuuHZQPsP+bnJMq9HbKqmuswAD+PCLMqrLvDP4ebcH
         rFuQSfTWX2hXXEeeSr4zAxkBoc/Tj/dcdpoPAt98uf9DRJCz2ljyVTh+37RVZglTrY5U
         llfC5qPU4Qy8lLZyi7XWKG8SqENKOtrK/vKvwJFfQWMjQgDHOD/X5zZ5/J9chEe9drC1
         0Mbm0lC9vLmy20t5/KeXcAwS4P6q+ZrUMIAvYsYAJ5LjsVQyxSzQkvCRiVC40kW22iRq
         XDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyxITQ06mRJ5LXE0g6/PDzDBVCahITkTQdAtCtjXbRA=;
        b=P38ElC7C8s1s4SZZIvKlhMCRcC8zpOVUP4obbDwHT7xf3CDfZ39NfqxJplSf19ye43
         Ld9eIFjwr1R9Pk8u2DqkrGkFLMD5IcoeUmASZ+POUfLG9AAiGKEU+cMfrpkWmhn8MtJf
         IS+BlD9pX30NdpIaNlB5rzzkRpBcNs4p+SwBQfjDTzUkRn6MyigDIV1stbR/JBBJEoKE
         M8I2LPk0T4V2dsbm+acjD7grEAeWWPP5pGfJcz1SmFPZ8NGGBIkqJ8rgthgIF14yVDkd
         Ztlk4NaYZtEe0SCTRjSFNMCHgA9iLz+WBLLDZcvIceff8df9LJ+2DweiiAdZlAV/Id4p
         VHhw==
X-Gm-Message-State: APjAAAVRwqesuUIx6DAkepmh4tsbQplhuFRS7xiatJuZJK44CCDCERIf
        hdPfjZ7GTHpnubIsZp9hWp3o3Q==
X-Google-Smtp-Source: APXvYqyVgAtb+6xBtEQEBbHXzoCRgoqXmWEYCLbkvrVum/DtSo090a7tfoaaZMEPBbMJH/GLEMmHxw==
X-Received: by 2002:a05:620a:139b:: with SMTP id k27mr72376440qki.112.1578096089492;
        Fri, 03 Jan 2020 16:01:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f97sm19409271qtb.18.2020.01.03.16.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 16:01:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inWsi-0005PG-Dz; Fri, 03 Jan 2020 20:01:28 -0400
Date:   Fri, 3 Jan 2020 20:01:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu, leon@kernel.org,
        Markus.Elfring@web.de, Xin Tan <tanxin.ctf@gmail.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] infiniband: i40iw: fix a potential NULL pointer
 dereference
Message-ID: <20200104000128.GA20711@ziepe.ca>
References: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577672668-46499-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 10:24:28AM +0800, Xiyu Yang wrote:
> A NULL pointer can be returned by in_dev_get(). Thus add
> a corresponding check so that a NULL pointer dereference
> will be avoided at this place.
> 
> Fixes: 8e06af711bf2 ("i40iw: add main, hdr, status")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changes in v2:
> - Release rtnl lock when in_dev_get return NULL
> Changes in v3:
> - Continue the next loop when in_dev_get return NULL
> Changes in v4:
> - Change commit message
> 
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

And Shiraz, Leon is right, that trylock stuff is completely wrong,
let's fix it.

Jason
