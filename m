Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E0A2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="dhYSWNgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfJJIkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:40:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbfJJIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:40:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id p14so6761333wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=42sItMr/D5Wq+0dBHN6jU3FpIi4hpB3vOynEYa+fIL4=;
        b=dhYSWNgKFNmhHl0NqJPT5ow3NshhQlWKNtRKhTYeImMosjkghw2gL/3AHxLstTJLOq
         eWCcECIzT4ogDpaZxN75m/JiyPIULduxX0ro0OQHY+2tFch+y8k/bphJ8nAC+c21WhnV
         Y626DgddgNawu0J2OpQ1MjSzzPWVJXuCtm1OfUkmP1sZBVTRSqLSf2zV8uck2MlUmSxp
         DeidlZqJZRkedsTnLiV3oc6+v7KlInIBTdaGYfnoe1fN8SK2Ww+Yv2mGT6zigAvVlWj4
         Mfo1S8aKgdZF0CkzW1eYAXrOclMiSPcjiCx6/vl+cEEkKjCbJeMYOmTjnm05dgQHw8Gr
         Df0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=42sItMr/D5Wq+0dBHN6jU3FpIi4hpB3vOynEYa+fIL4=;
        b=R0Ljlc+zM5LkfwrgOybCxjweyBU8Ye1phqaLvMyACCgcksPPIvrXpcigdI1OtnC/M7
         M1BMSoOV3p+bmGFmPFPKCVGSKgHiRHTiJJWAvU2p8vcWVxE6kuKZ4lf9eJdLEcskKv7u
         JJrnxXwvrqQbC3yrNvdLVnQyOsGqbvUeEfji4PnDg7YG16BP/zmZFWNBVuk1BxjFo6e+
         OkoTFORSS5cMG/1/57w1yqA3tnEJY78qMqXcQYyiwMH1I9eWnkQfzFYguPXhY4uvFWsB
         mOTCgkcO6fddUKB9RawOz+vvffMSKWl3nY/8m/RrPUJUe6Bw/01q9W5+dO6os55njWHe
         8SqQ==
X-Gm-Message-State: APjAAAU3QxaoeGbVK3Vj0P2IDRjdkwBeI4iUf0EwfQFBzPpfxap8rcvO
        jPmu3Ahj2Hhf9QS71yPPaxBRfvkAONI=
X-Google-Smtp-Source: APXvYqxXDLcHSE+XNsIjvfnqyotxzvbC5wQAIEmI13p0v9dqe+EUFrm3Bo9qzz0Y1KIqdkqrmlcqIQ==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr7270590wrn.156.1570696800479;
        Thu, 10 Oct 2019 01:40:00 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id m18sm6742626wrg.97.2019.10.10.01.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:39:59 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:39:58 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] genetlink: do not parse attributes for families
 with zero maxattr
Message-ID: <20191010083958.GD2223@nanopsycho>
References: <20191009164432.AD5D1E3785@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164432.AD5D1E3785@unicorn.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 06:44:32PM CEST, mkubecek@suse.cz wrote:
>Commit c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing
>to a separate function") moved attribute buffer allocation and attribute
>parsing from genl_family_rcv_msg_doit() into a separate function
>genl_family_rcv_msg_attrs_parse() which, unlike the previous code, calls
>__nlmsg_parse() even if family->maxattr is 0 (i.e. the family does its own
>parsing). The parser error is ignored and does not propagate out of
>genl_family_rcv_msg_attrs_parse() but an error message ("Unknown attribute
>type") is set in extack and if further processing generates no error or
>warning, it stays there and is interpreted as a warning by userspace.
>
>Dumpit requests are not affected as genl_family_rcv_msg_dumpit() bypasses
>the call of genl_family_rcv_msg_doit() if family->maxattr is zero. Do the
>same also in genl_family_rcv_msg_doit().

This is the original code before the changes:

        if (ops->doit == NULL)
                return -EOPNOTSUPP;

        if (family->maxattr && family->parallel_ops) {
                attrbuf = kmalloc_array(family->maxattr + 1,
                                        sizeof(struct nlattr *),
                                        GFP_KERNEL);
                if (attrbuf == NULL)
                        return -ENOMEM;
        } else
                attrbuf = family->attrbuf;

        if (attrbuf) {
                enum netlink_validation validate = NL_VALIDATE_STRICT;

                if (ops->validate & GENL_DONT_VALIDATE_STRICT)
                        validate = NL_VALIDATE_LIBERAL;

                err = __nlmsg_parse(nlh, hdrlen, attrbuf, family->maxattr,
                                    family->policy, validate, extack);
                if (err < 0)
                        goto out;
        }

Looks like the __nlmsg_parse() is called no matter if maxattr if 0 or
not. It is only considered for allocation of attrbuf. This is in-sync
with the current code.

For dumpit, the check was there:

                        if (family->maxattr) {
                                unsigned int validate = NL_VALIDATE_STRICT;

                                if (ops->validate &
                                    GENL_DONT_VALIDATE_DUMP_STRICT)
                                        validate = NL_VALIDATE_LIBERAL;
                                rc = __nla_validate(nlmsg_attrdata(nlh, hdrlen),
                                                    nlmsg_attrlen(nlh, hdrlen),
                                                    family->maxattr,
                                                    family->policy,
                                                    validate, extack);
                                if (rc)
                                        return rc;
                        }



>
>Fixes: c10e6cf85e7d ("net: genetlink: push attrbuf allocation and parsing to a separate function")
>Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
>---
> net/netlink/genetlink.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
>index ecc2bd3e73e4..c4bf8830eedf 100644
>--- a/net/netlink/genetlink.c
>+++ b/net/netlink/genetlink.c
>@@ -639,21 +639,23 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
> 				    const struct genl_ops *ops,
> 				    int hdrlen, struct net *net)
> {
>-	struct nlattr **attrbuf;
>+	struct nlattr **attrbuf = NULL;
> 	struct genl_info info;
> 	int err;
> 
> 	if (!ops->doit)
> 		return -EOPNOTSUPP;
> 
>+	if (!family->maxattr)
>+		goto no_attrs;
> 	attrbuf = genl_family_rcv_msg_attrs_parse(family, nlh, extack,
> 						  ops, hdrlen,
> 						  GENL_DONT_VALIDATE_STRICT,
>-						  family->maxattr &&
> 						  family->parallel_ops);
> 	if (IS_ERR(attrbuf))
> 		return PTR_ERR(attrbuf);
> 
>+no_attrs:
> 	info.snd_seq = nlh->nlmsg_seq;
> 	info.snd_portid = NETLINK_CB(skb).portid;
> 	info.nlhdr = nlh;
>-- 
>2.23.0
>
