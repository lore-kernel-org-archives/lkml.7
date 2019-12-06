Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994DEC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3DC24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjC6izhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFO4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:56:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbfLFO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575644190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZiMi9GA37xMLOFTmxZhVvHZSfLZNfqkbCgqTYdRzFY=;
        b=FjC6izhK/lPZrkQdYHo6FDSmUcrCGYG5ztisH2XEMcorA2nhIXfsVHCEAWP+IWE8KSI93U
        hvGgmT1fZ+WlFGjxNrCciSEY2ogkPvDU59kcUHctThdnXz6Jcl/99XvO8vkjcYooNopuwB
        da/TqWS0uW6K8hVuwAILwT1JbgoEQGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-sZ0zvLs4NSajEdUBzlGsHA-1; Fri, 06 Dec 2019 09:56:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id f1so1258289wre.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKbuZUAf1dCKq8jnpQSBCg+axcK4Bo/Qt06gTAOaFYo=;
        b=U++c+Yfh0b9XJPLtRmh5oX+9EFRDH+6Httx5z+wJuzoXoIZolkbcSjH8PbAJhsUkXI
         VNQaSz5fpKMRnRnFeZAYwVbLnxpUTJJaxouOZk07LXWEiy3/yShWAglDdC59mpE0anBr
         /R7lq1zyvT2kAiutGYpyWGTD0Zo8CXmQRQpOT6RL6VlSUh+0lN3yTTdfhw/rYZSi5W12
         cjoXOgACz8MMVAhsYsrawQmSi3QX2zxQOvVZVyS7MApADi4zi0yeWFRoTnhtQVAkj0R/
         GSYg5RIEuxv2FFG4WLduhftwLrxN+3b1wN+ynZWCawxybBTU2VrOzE2dLBmHWkkTUc7q
         bl3w==
X-Gm-Message-State: APjAAAUHxg5b9lo7t6JipqefWtIgMIWPDdlFgqcJrW+3Pmme9SB2kg1D
        fD9CS5F+RstYQQy8aC2VlXv3ldGI5qbKp0+DW6MxSY0CVeU760nnmlSjUK4iVB2rTkgnB7MBEh5
        GszpUspqxDe/DQfIaz1oupmsV
X-Received: by 2002:adf:b64e:: with SMTP id i14mr15788165wre.332.1575644181994;
        Fri, 06 Dec 2019 06:56:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaVmms+HbzDV1KRBndmLQS8NM9mEPWrhOpX+hnkWl6jR7C0hNyGAx2B3bhw8bgSaKH9RTz/A==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr15788150wre.332.1575644181828;
        Fri, 06 Dec 2019 06:56:21 -0800 (PST)
Received: from linux.home (2a01cb0585290000c08fcfaf4969c46f.ipv6.abo.wanadoo.fr. [2a01:cb05:8529:0:c08f:cfaf:4969:c46f])
        by smtp.gmail.com with ESMTPSA id k20sm3385389wmj.10.2019.12.06.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:56:21 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:56:19 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     klju@umn.edu, Michal Ostrowski <mostrows@earthlink.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pppoe: remove redundant BUG_ON() check in pppoe_pernet
Message-ID: <20191206145619.GA3930@linux.home>
References: <20191205230342.8548-1-pakki001@umn.edu>
MIME-Version: 1.0
In-Reply-To: <20191205230342.8548-1-pakki001@umn.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: sZ0zvLs4NSajEdUBzlGsHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 05:03:42PM -0600, Aditya Pakki wrote:
> Passing NULL to pppoe_pernet causes a crash via BUG_ON.
> Dereferencing net in net_generici() also has the same effect. This patch
> removes the redundant BUG_ON check on the same parameter.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/net/ppp/pppoe.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index a44dd3c8af63..d760a36db28c 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -119,8 +119,6 @@ static inline bool stage_session(__be16 sid)
> =20
>  static inline struct pppoe_net *pppoe_pernet(struct net *net)
>  {
> -=09BUG_ON(!net);
> -
>  =09return net_generic(net, pppoe_net_id);
>  }
> =20
Looks like a net-next patch, but net-next is currently closed (take a
look Documentation/networking/netdev-FAQ.rst for details).

You can add my ack when you repost:
Acked-by: Guillaume Nault <gnault@redhat.com>

