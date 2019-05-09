Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853DE216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Wj8IycJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfEIPkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:40:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46259 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfEIPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:40:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id v17so2654978otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSzZV65JqCtXVXp3jlprv98tNwKpdM2hfn5arWFOHlQ=;
        b=Wj8IycJkrri//lG167IMCLkpOF3P0RDxUTLSG3qf9PCTxjX6DB+bZDqLo2GKXYpIUf
         94bR8IgO7nRPbkGSFYZHQVN0lU1j6cz8KrLDPTP3KwkFZqctJwA+D8F2qyn16FimrDmH
         H5jjZi+ZDGieYHHhmUB29OScA2PIGo+DMzXF9jd/7XwemUkPWQKR1VryhTn6yT2eolZ6
         QONFr619BXzyo+BPB4fPNS3KtX6h31ZRXuc1elagjPwt9M1Flreeam4G5G5vfbKRfSfy
         Y+8ExhrjY6/TcnA9Fg9D4UQN9M0PcpY0mWTlGB3qfPw1Cq57BSZNqHdPIkJm3mV1j2T+
         Tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSzZV65JqCtXVXp3jlprv98tNwKpdM2hfn5arWFOHlQ=;
        b=sB5IV5C6ObpJ45mv/6biPymqJoigohpldg+VD8fHyoJBqmZN0nMtCfFr8XGf79LNMl
         XhM3PQCsdayni94s70ZnZQNQ+bOOwrS69T45E4HGsvOJdD/B1CRAl4+KsdHl8cwz6lqn
         ezszK7jzl9YW/mKqJKy+DDzeeUbz+Ax3PDdhYrG21jbLpNZga601JnPTNyR1WCKncSGs
         55RmU/HDwaQJe1MRF2iOhAVYmF9LZR5egyyu5iBygCNyj7clvaXlShLkYDenUvCd0XZf
         k5S65pv0edc1PC9zhE3aSkOQ7Ap0eC+eMQEMpu6rTD61ODgrRXhKTiyH8IGVLr5lv6oe
         CyHw==
X-Gm-Message-State: APjAAAWAJbC5miTyIpH0TKPARaH4XhfKZr4KqZnI6tovdIjdtyhEcaDJ
        lJajrWbYm35kkLO090k/AC06TQ==
X-Google-Smtp-Source: APXvYqzhrR/B1Ofdn+/XkOJi4J9l1K72xcXghvK7Q4wTyN1HvQcy2LB9NlYNQ6igJr8sgEA2B0kobw==
X-Received: by 2002:a9d:826:: with SMTP id 35mr3067127oty.114.1557416404417;
        Thu, 09 May 2019 08:40:04 -0700 (PDT)
Received: from brauner.io ([172.56.6.91])
        by smtp.gmail.com with ESMTPSA id c131sm949673oif.33.2019.05.09.08.40.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 08:40:03 -0700 (PDT)
Date:   Thu, 9 May 2019 17:39:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] fsopen: use square brackets around "fscontext"
Message-ID: <20190509153957.ahqqxwzipdvjxudo@brauner.io>
References: <20190508152509.13336-1-christian@brauner.io>
 <20190508152509.13336-2-christian@brauner.io>
 <20190509153902.tqkoooxtviafrla5@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509153902.tqkoooxtviafrla5@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 05:39:02PM +0200, Christian Brauner wrote:
> On Wed, May 08, 2019 at 05:25:09PM +0200, Christian Brauner wrote:
> > Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
> > This is minor but most core-kernel anon inode fds carry square brackets
> > around their name (cf. [1]). For the sake of consistency lets do the same
> 
> This "(cf. [1])" reference was supposed to point to the list below. But
> since I rewrote the paragraph it can simply be dropped.  Sorry for the
> oversight.

I'll resend with the commit message fixed up.

Christian
