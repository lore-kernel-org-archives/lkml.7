Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFBFCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4985E20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qZG6MBc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbfJWKBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:01:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37403 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403810AbfJWKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:01:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4so15294917edy.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5emlzdBcyQKRWblamuH9LkuU6rz1TF+chv1k3FvAKlk=;
        b=qZG6MBc/wMQBruGKlUudZ16Cy3/0u1rYy9yPr4J8lmbHSVjI7U3DwofG4OG50HL0l6
         joV4svx4AWbdEiKn+VTlvf5xCMAF4mnBgR4xRY6yegpME8eLp1JxPJx2mXQnXuhm+bBu
         I9vnea61du2YbZZfi4HYX6xiLdy1Rnfemt8WOTu2o7z//ypGoruF50FdbllXhUUi5yyr
         o6Ly1WBFcoXw4jJAIBbsegJkuLjUl1qVQ87bJ2+djojwE1Va6ACuK1bhzAk7RxY2wBCT
         i7SI82iaSPdh0AwMlwhhe15b+SShSxOX3/AsrGFqWdVyoRb/3N5c1Ar/kfz1ppMDYvUi
         FulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5emlzdBcyQKRWblamuH9LkuU6rz1TF+chv1k3FvAKlk=;
        b=Ef1HRLRxuGUjn3ZOAcYPX1+wSLIeI+F7/iICR6QIijlT0WqRobjByTOJcUT4HNrgL8
         UrcMN4Fl/rIb54kGoD9jfoJPuLdVZHglkX7fkza6q64oGs2POutDplT1k2CgtUjcL3hJ
         W591DA5V8fD2xjNVxf9oy7fUgRiGqE1wC7S5/NsTG9K3iC28URrduKD13y69g/cCjrFZ
         CQK8XVRPwVUsKye6jo5pRiFyU6yv30WgRdR5CIfR+V91D/hxgV2PPqfuo3hmLP0ajg67
         T7TVqCTSBQuDRIJmmVPq7oiYCH9ZbIPBGIgtz7tZ5QZj5Qh2twT/nEsCbtLQsCvZso6L
         4wRQ==
X-Gm-Message-State: APjAAAVgbAbHRoiHdhDff9cmhi4/lMiH4awPmEC9vUg35C7l/USfnA3W
        6ju0tQyrOj8OcaMlYA3KoNi+VQ==
X-Google-Smtp-Source: APXvYqw8dDyDfX6iQ1Eb5GA37WmLKMyPTrnlnq5CcNkjMARm/3a+NWS7xK7hnKz7gJ4YxFd2hmYpBw==
X-Received: by 2002:a17:906:4d4f:: with SMTP id b15mr8904707ejv.81.1571824897561;
        Wed, 23 Oct 2019 03:01:37 -0700 (PDT)
Received: from netronome.com ([62.119.166.9])
        by smtp.gmail.com with ESMTPSA id a22sm426052edv.7.2019.10.23.03.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:01:37 -0700 (PDT)
Date:   Wed, 23 Oct 2019 12:01:32 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller " <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] bonding: balance ICMP echoes in layer3+4
 mode
Message-ID: <20191023100132.GD8732@netronome.com>
References: <20191021200948.23775-1-mcroce@redhat.com>
 <20191021200948.23775-5-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021200948.23775-5-mcroce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:09:48PM +0200, Matteo Croce wrote:
> The bonding uses the L4 ports to balance flows between slaves.
> As the ICMP protocol has no ports, those packets are sent all to the
> same device:
> 
>     # tcpdump -qltnni veth0 ip |sed 's/^/0: /' &
>     # tcpdump -qltnni veth1 ip |sed 's/^/1: /' &
>     # ping -qc1 192.168.0.2
>     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 315, seq 1, length 64
>     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 315, seq 1, length 64
>     # ping -qc1 192.168.0.2
>     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 316, seq 1, length 64
>     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 316, seq 1, length 64
>     # ping -qc1 192.168.0.2
>     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 317, seq 1, length 64
>     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 317, seq 1, length 64
> 
> But some ICMP packets have an Identifier field which is
> used to match packets within sessions, let's use this value in the hash
> function to balance these packets between bond slaves:
> 
>     # ping -qc1 192.168.0.2
>     0: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 303, seq 1, length 64
>     0: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 303, seq 1, length 64
>     # ping -qc1 192.168.0.2
>     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 304, seq 1, length 64
>     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 304, seq 1, length 64
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

I see where this patch is going but it is unclear to me what problem it is
solving. I would expect ICMP traffic to be low volume and thus able to be
handled by a single lower-device of a bond.

...
