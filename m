Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D661206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenbI0zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfIRUlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:41:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37271 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfIRUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:41:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so1197210edy.4;
        Wed, 18 Sep 2019 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZ7DKIGHFm80s3ARjnKuzOsZg23fCSETwrVjMRDlLxg=;
        b=fenbI0zJZu4Yt614qPx6VxFUjQdIlQtFPp3l3/fFEIX5fGiTNDSH2IIwGv6DubGgg1
         HnYCusZcSbV8Kw7CT9ZXriZWIr8nTWiylDIKpPuglifFt8h7RDqvzphBn/grvdKCEIn8
         GcI7z9Z9pM/aWr5xN9f+9mDo/Ryp1+Hvkw9naRjEtGyyn9LHVKrA+57J0LYN8nRsHbKB
         OVeZ9UPEY9QdgcvWRLbKBjqTHoJ6RdLQwzpafRn5cpuo5PnDzXEAKWClIb5aPtnJIBQ7
         kv1Z+3j3YpaDXu3qIvyJaZcT4/it4/r6rWGLUnVZQDPuNwiIFObRSpFl8VQ1HE+4ra52
         Jp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZ7DKIGHFm80s3ARjnKuzOsZg23fCSETwrVjMRDlLxg=;
        b=deEMroO9AhH7J1PX+MkhO9sneBUzNt+e5+d1Kgo+8T7dCLnKaVqnR2zDhrfq0/R7+N
         vIaM0RFVyVB4P8qWdnz+824umNettRAN+jAk5TZ7X4hiXS4ocpWYgEe8Zzd/DzbJyo+v
         7cWiicU5pXCSyBwQVabdJNWbW0mnlV9AWAcPZpL26w99JI9WvSLDV7EizHQaG4pvwCMC
         KN0aAcpsqhU9gHcuXEiOfqGowzvyIxGyXBwiVJyirtCqdLlerPDFMy75hQGDXKsR+64D
         L/pYxfyQkWaHC9MUcgBPaJ0gSRSAbV4jLHCPBKeNcqY8FvyTivUhIWiQWRUxQAG1JQCc
         MQbw==
X-Gm-Message-State: APjAAAUgLkDltOP7K8mIOibGe35wxbUsbzSDg/2ICM+VizHCvDG2w4wA
        aHcyr9xN9UlkCdjA9OhskXVSMEUbhyJHQS4V/Xs=
X-Google-Smtp-Source: APXvYqxp61F1SCtTmix7V21uQiAP4xfPpWa/Mhst+rFL5TjzmjgaTb8GNbnY8IHhfQ+QwBMTCPVbjJeC1CWT8GnVWzc=
X-Received: by 2002:a05:6402:14da:: with SMTP id f26mr12452758edx.165.1568839270328;
 Wed, 18 Sep 2019 13:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <8d6f6c54-1758-7d98-c9b5-5c16b171c885@gmail.com> <20190918203407.23826-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190918203407.23826-1-navid.emamdoost@gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Wed, 18 Sep 2019 23:40:59 +0300
Message-ID: <CA+h21ho_pibJNnYkyYrJGACmwU16Qk3ZZ=BJEqQjBbK3CW+Gog@mail.gmail.com>
Subject: Re: [PATCH v3] net: dsa: sja1105: prevent leaking memory
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, kjlu@umn.edu,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 at 23:34, Navid Emamdoost <navid.emamdoost@gmail.com> wrote:
>
> In sja1105_static_config_upload, in two cases memory is leaked: when
> static_config_buf_prepare_for_upload fails and when sja1105_inhibit_tx
> fails. In both cases config_buf should be released.
>
> Fixes: 8aa9ebccae87 ("net: dsa: Introduce driver for NXP SJA1105 5-port
> L2 switch")
>
> Fixes: 1a4c69406cc1 ("net: dsa: sja1105: Prevent PHY jabbering during
> switch reset")
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

>  drivers/net/dsa/sja1105/sja1105_spi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
> index 84dc603138cf..58dd37ecde17 100644
> --- a/drivers/net/dsa/sja1105/sja1105_spi.c
> +++ b/drivers/net/dsa/sja1105/sja1105_spi.c
> @@ -409,7 +409,8 @@ int sja1105_static_config_upload(struct sja1105_private *priv)
>         rc = static_config_buf_prepare_for_upload(priv, config_buf, buf_len);
>         if (rc < 0) {
>                 dev_err(dev, "Invalid config, cannot upload\n");
> -               return -EINVAL;
> +               rc = -EINVAL;
> +               goto out;
>         }
>         /* Prevent PHY jabbering during switch reset by inhibiting
>          * Tx on all ports and waiting for current packet to drain.
> @@ -418,7 +419,8 @@ int sja1105_static_config_upload(struct sja1105_private *priv)
>         rc = sja1105_inhibit_tx(priv, port_bitmap, true);
>         if (rc < 0) {
>                 dev_err(dev, "Failed to inhibit Tx on ports\n");
> -               return -ENXIO;
> +               rc = -ENXIO;
> +               goto out;
>         }
>         /* Wait for an eventual egress packet to finish transmission
>          * (reach IFG). It is guaranteed that a second one will not
> --
> 2.17.1
>
