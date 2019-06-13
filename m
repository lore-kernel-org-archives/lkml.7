Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F9FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfFMTnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:43:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:41062 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729099AbfFMTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:35 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x5DJhXTF026366
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:43:33 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x5DJhS14016559
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:43:33 -0400
Received: by mail-qt1-f197.google.com with SMTP id r57so56660qtj.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=X52JplcHmEO24WIh6SWrgs4nyWiRwpwGk4gdSxuZXbE=;
        b=qvAzPvVOBBxzmKVxf3XjHyKM2/2BAXSIqjooqPgA86SYC/j9vu+BGbeiHHbWPwaT2M
         8MjvJpb5kSiAn6wLtI0mDfOMeFhYDZBrtUQiIR+1D6YSYoYX4JGfckMbyvP/ZOpBcBVo
         aptgPhC70b3RLWNhjjt2qaJhI7qYf1V90HYeCmWXAmVnYN7v6MyW3PrJC5mjcFkmEQ0Y
         YpdbuCLaNGwJ6NqYYMrkOx5sym0KKqxIybambkvnPuq6E4Z6I7kJdDbhd0QBbXxDcu1N
         0Y3mJkWWd78x+Quh+ehQ9lEo61KdtxNSt3pOYYF4ZGlLzOsPDhm6qJ9VlR6WEMtYFxRC
         NeIw==
X-Gm-Message-State: APjAAAViEEAXd76OGm5nJ42EOv/eLcN2ojcvMFkhViRMuBvu5si2gr6e
        vSTIZHQavI2ME7utez4zqggcRF3KcEC/QqLUQP9bZAMo7+pNNYsTox0LL9KAJ3o11ktlF9EILd3
        JCYvyNsDcOkLOY1/nMTgWIZjdIeIyurIEiE0=
X-Received: by 2002:a37:9904:: with SMTP id b4mr69899933qke.159.1560455008498;
        Thu, 13 Jun 2019 12:43:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/GJE2V91Zh0MxHybXn2y5+GO1Jea75666JvUr6PlEA6YbxgoAIKT/lUM59yF2MsveYuo8fg==
X-Received: by 2002:a37:9904:: with SMTP id b4mr69899921qke.159.1560455008211;
        Thu, 13 Jun 2019 12:43:28 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id g10sm255967qkk.91.2019.06.13.12.43.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 12:43:26 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Shyam Saini <mayhs11saini@gmail.com>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, pedro@palves.net,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: Pause a process execution from external program
In-Reply-To: <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com>
References: <CAOuPNLifSHQmi+jCMzRGYz3kzct+NB_vyv-yiwL91adRZPkTrQ@mail.gmail.com>
 <CAOfkYf7BZ1Ttrm7iVioq4mxZcJy7V44gNmusavPzgi=59=TY6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1560455005_1690P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Jun 2019 15:43:25 -0400
Message-ID: <13999.1560455005@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1560455005_1690P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Jun 2019 13:22:12 +0530, Shyam Saini said:

> from command line we use ctrl-z to stop execution of a foreground
> process but you can program
> SIGTSTP signal handler in your application code to do the same.

Note that if you simply fail to include a signal handler for SIGSTOP and
SIGCONT, it will Do The Right Thing.  The only programs that need worry about
SIGTSTP are ones like 'vi' that may want to do something (like restore the
terminal state from raw to cooked mode, etc) before they stop.  That's why you
can control-z /bin/cat without it having to include a signal handler for it.

% kill -STOP `pidof process-to-stop`   # stop it
% kill -CONT `pidof process-to-stop`  # and make it run again.

No source code modifications needed.  No source needed.

Now, if you want to make it stop at a *specific point*, then you're into
ptrace territory, and source will be helpful.


--==_Exmh_1560455005_1690P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXQKnXAdmEQWDXROgAQIeDw//Vd5MvV/dpjk/37ifTcCOaMbGdI+3J42H
ezpQoqoCZcJWasZ9KT9C/UajS7SSbxkCBWvVxo0DfD74QoKkCKQggwEqSBzfXxL/
JgdbtjIJobc2uR164Qw5H9olFEp2gXKRe1CudT0EhNr6c0Rg78+LQcDocOylsSNl
4zo/SptYmpVPZsgPhnmNPI+y8A0kYYNDSUkVSyh6rgmbrebeXvL3XW/fvwTuSOow
ZRaJrp04pwjPKb3YgV+TSySwoMyj7l84NS/RLaLrjXLj34t8dCgLJWOdfv+liskL
u+ByCt0w6sAr/tCfx05d+PH1elW1RC4lRYwUbfMIpXopQYBlRp0tO+A1nug/dnBA
04PbD0mBz7ECETJsgmY9JY5g7yEdjRUDBuiQabyyA4sbcLMH4Cr8ANflwbLB14Lj
WRfYcsYRHQdOeK4MeKwPnY3zqDqQ5m5OuKrNKUz6plM/fvrhhkDTwSnV6UkIfqXH
3gy2xlFARWN+vIcRHs6ZPmo7ocffqilbsk8WMVO9HOsE0NgX8VFgvWqkTD72e6/q
i39rfP0iWaugJMN4+ZO9VK2NYvUCQS8/8n4+NdtVwl96OEyHGmSK51E901EL4f+b
EBPhFAk/EXqm/DIK3i7uPmte3lWHXXgGKcwkdWMfd8KUp73agSHN41VPXQIl5CRj
bklUeXvuZKs=
=hF6e
-----END PGP SIGNATURE-----

--==_Exmh_1560455005_1690P--
