Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE492077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CjUWiJmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfH2QoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:44:12 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45965 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfH2QoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:44:12 -0400
Received: by mail-ed1-f41.google.com with SMTP id x19so4713996eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=J0mIptJpgCrji3rnOXUkwAg2sK122VXt0E9fIlxztOM=;
        b=CjUWiJmEnPc7cpwJ/wsprTOwzmCKVjptR7CYO147EQ8lCVLk9PNsUUNihGjDi0yAiU
         AdhSK4kl0aEt2i34anAuJ5CHeotYjHF8tIYEm3pizhouRuUK1YrIQE9k7itxJ0YcnexA
         2xxmCkBC+zU1PddIE30q0E+GQLwS5xXelvTGwgwTgCRHUc1mpEfEbNdN9FaevS84+w0A
         KKda+pmQs9qgR1c9qFKdc00Mlryh7p5phtUGHaZ50O+d2E8lL9LWq8PdysrjSDlD/08l
         rDCf6VUX8OHUCdYLvFfNVFqqKJyeiQ3PwuqXv0ooKBfDDDwygOUbgOX0gZqeldc+118y
         0m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=J0mIptJpgCrji3rnOXUkwAg2sK122VXt0E9fIlxztOM=;
        b=rT5l54nwonyWI8ISn5fC5K2YxuYxJj/9geNSJnk4qYz8Bzi7PEMkZSyUtmuFEjDM1Z
         NYnoOPSHcUUnnj8jDSwRzDrRxS0R7qnWKqtktTLgyRgvk91njgNEGxdmwUJwMDH7qe9s
         KiYqgbvDbecI77JPN0bT5yts1FCj3f1xGgU1J3Y3hX90b3mPL2mpPZiNCHVzbi5OJL3y
         unC9AHXgIl0E7QoOiNoe5iFKFuhBXWv3it1B6ONuLrpokIU6/Q7fDFV904bNX0X9+ZRU
         ybpUAV6zJ5nJ4sNcazTtNKoXEx6KoUQE0DoyQ+BlK6sHFEb3Hgt6OqTpwu/Ja/YeBt2N
         Mubw==
X-Gm-Message-State: APjAAAXEDGXMa4+mgEEMq92oDS1yaGS52rs3cy6vAWm5aPIWp6OWWria
        IVrmzliiNjdQ3umDn/+HOyu2HA==
X-Google-Smtp-Source: APXvYqw5Xs+f6YJcpXnaAvDOyRlabm5hOEmNVZx7gCr2PPOar2OUA5f1/a+08qrVc12CFDoVIZHybA==
X-Received: by 2002:a50:884b:: with SMTP id c11mr10893613edc.138.1567097050284;
        Thu, 29 Aug 2019 09:44:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o11sm444273ejd.68.2019.08.29.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:44:09 -0700 (PDT)
Date:   Thu, 29 Aug 2019 09:43:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     john.fastabend@gmail.com,
        syzbot <syzbot+7a6ee4d0078eac6bf782@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in tls_sk_proto_close (2)
Message-ID: <20190829094343.0248c61c@cakuba.netronome.com>
In-Reply-To: <20190829035200.3340-1-hdanton@sina.com>
References: <000000000000c3c461059127a1c4@google.com>
        <20190829035200.3340-1-hdanton@sina.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 11:52:00 +0800, Hillf Danton wrote:
> Alternatively work is done if sock is closed again. Anyway ctx is reset
> under sock's callback lock in write mode.
> 
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -295,6 +295,8 @@ static void tls_sk_proto_close(struct so
>  	long timeo = sock_sndtimeo(sk, 0);
>  	bool free_ctx;
>  
> +	if (!ctx)
> +		return;
>  	if (ctx->tx_conf == TLS_SW)
>  		tls_sw_cancel_work_tx(ctx);

That's no bueno, the real socket's close will never get called.
