Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8B5C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B31B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="y7nfCg4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbfEXNHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:07:46 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36046 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391357AbfEXNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:07:46 -0400
Received: by mail-vk1-f195.google.com with SMTP id l199so2107357vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jdBUUMv99kj0cqC35xVQ0vJ+lTbAYnC4lk5/+dSwqX8=;
        b=y7nfCg4b4hWh5cXtClN2G9IlPfZtmsJ3lCmnJcQFhJJFfR7Duny76GHmGWVmLX7JkN
         4BQJt1/DlmVVHNx6yxD8f1v1vebpwhOW/ZIYNZ2RvPKxui5ELigztwF3+awy6EBQw7wE
         m3Y2E5XpbLeF2AxgqwDhp4aX77GeAAP51wkhJr9AxhH+GkIXWwNH8VLVQGaBoN8GvqUp
         A8Sh1fZjhD6lSYCc2m9pwMqc/p7T2nlHT50o9OXZ1RUVaIxCKjYUX676pmynjMX0a5ue
         bReHsYh0ssps55JEZQvYZbYbEun8Ea/68G3H264PjF491twDM4RQQrC4Rib1pUZoFXKT
         CZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jdBUUMv99kj0cqC35xVQ0vJ+lTbAYnC4lk5/+dSwqX8=;
        b=nIaRGOd+/H669H/0OVgpoomnVl96nd7uwkayNd3VBJtzC2m/tI3HdfpYQhr3wWTsZ/
         Ci3lCrQiIvhrzIl+CKsEnDFevXj2/I2evyHw+cua1NfSmIWsDghjrkhoVAPaP3C+gSCI
         RaNub6cA5j3FDy1qyJhdRrmuIWIcXr9fJpFfGEWMp7zCby8NmDeilUbwIsq6vDNruONJ
         ri4oDSiak4FjA9jKT21acwhThFPg48ZvnT+nBM6M1H7nEV1wN7HhNCaMc1Rpom/b0iPh
         9vFiM58fosjwAYjPTjQz3AHGqTLAEJPBecGpGsQYiBO+v6d02S4rl2DwXv6t3j4/UiF0
         cQIQ==
X-Gm-Message-State: APjAAAVujdCGjSmZGU9f93RDgS9Uax+Kvv0eEYffgFjKGiXkp35iZpND
        sIGmM5110+phC/MofmgUk1eSg60xqsdK1w==
X-Google-Smtp-Source: APXvYqwvZqoB7HcLldyB5hnboWptllAQCHpm5/Temh8iNOZUGFHOn/N74uzD1wlGnZSad8s+yXbosA==
X-Received: by 2002:a1f:8d0b:: with SMTP id p11mr4674585vkd.31.1558703264670;
        Fri, 24 May 2019 06:07:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e914])
        by smtp.gmail.com with ESMTPSA id v14sm815351vkd.4.2019.05.24.06.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:07:43 -0700 (PDT)
Date:   Fri, 24 May 2019 09:07:42 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nbd: fix connection timed out error after
 reconnecting to server
Message-ID: <20190524130740.zfypc2j3q5e3gryr@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:43:54PM +0800, Yao Liu wrote:
> Some I/O requests that have been sent succussfully but have not yet been
> replied won't be resubmitted after reconnecting because of server restart,
> so we add a list to track them.
> 
> Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>

Nack, this is what the timeout stuff is supposed to handle.  The commands will
timeout and we'll resubmit them if we have alive sockets.  Thanks,

Josef
