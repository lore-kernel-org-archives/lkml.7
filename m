Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEFECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437020650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSGRlTlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405493AbfJWU4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:56:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405172AbfJWU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:56:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id j11so10684464plk.3;
        Wed, 23 Oct 2019 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=07Atb/6gQrkEJ26f3FmK/lTnstI+R5Npacag/JwqRmk=;
        b=NSGRlTlNMvNDTQo1Xgl6h/5SFLy3iEek92UpZddKGZwMLi9rm6RGvCk34EEpwcvnXY
         2+iMcWENqwCSRCNothH74ArZl214/hY0l0D9qRpmD9sb5aagimUCcGhyKMcHY927Ztwg
         c88Zb6dfsK9zLrmOUlKGkQ2OaAFRbcpk5PdWx48PbkJ7hAVXVVvxvFBHzLsKrx3KZh+k
         oloiMzC1jMAVMs/Liz/LR49VcZKDdLsreuOQ6U3adWpOj4qEzFBih0FqRCrcz6T5PiG6
         HZ4oILYz0NCSUjw/wa9Tp5fwowIlK2sD0Z0BNE00hFKfbXJ63XlUvWc52Ww4rmQsBja3
         RQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=07Atb/6gQrkEJ26f3FmK/lTnstI+R5Npacag/JwqRmk=;
        b=KSZ++CNyggKwxHz176xD2xhKjW/B98z3sQga8cITRNGkFrro6mktT4BgV20JqZF7At
         e78ZFxjE6BpxvCtYUyDTzAijhwik0L3VyojAp/Y6Wa0kXaUFsMdJ7L21aHIoaZO9awmc
         4V6s+Esrj/7/aeyGreJ4CWJ9vi8oOaAxFe8+dH8vZ3TKNSpZtCHgmlU1dqWgE/Da9cRd
         x4LCqzB8K4IK/nFE016Q5G/MGyEQ7WtK95DKbZNVhEceJ/ORq065+c9Ohgy5T6ZlnwFX
         CCBMee/GlQTYzxDdY4/3XPt1r84zRFX7Ngy3hos5wCcqgry4UIWwPbLr9sJM04kZK8si
         IE/A==
X-Gm-Message-State: APjAAAW0KI/0psAoedB8f1Y9HxCT07qtIG/G5IlpSklHc1Qd4UNzeU+f
        /a3I7Y0ZVFa2R94hpD7P/A==
X-Google-Smtp-Source: APXvYqycKSXQGXAynFiufHVxYiQKe72QcM+36tuPsviNgI9wA+eb7Uq7f9nUd8r5SmkPlCDem3pktw==
X-Received: by 2002:a17:902:d70a:: with SMTP id w10mr11144217ply.342.1571864165109;
        Wed, 23 Oct 2019 13:56:05 -0700 (PDT)
Received: from localhost.localdomain ([216.52.21.4])
        by smtp.gmail.com with ESMTPSA id s11sm131885pjp.26.2019.10.23.13.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 13:56:04 -0700 (PDT)
From:   Praveen Chaudhary <praveen5582@gmail.com>
X-Google-Original-From: Praveen Chaudhary <pchaudhary@linkedin.com>
To:     fw@strlen.de
Cc:     astracner@linkedin.com, davem@davemloft.net, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, praveen5582@gmail.com, zxu@linkedin.com
Subject: RE: [PATCH] [netfilter]: Fix skb->csum calculation when netfilter
Date:   Wed, 23 Oct 2019 13:56:02 -0700
Message-Id: <1571864162-9097-1-git-send-email-pchaudhary@linkedin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20191023193337.GP25052@breakpoint.cc>
References: <20191023193337.GP25052@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian 

Thanks for the review,

inet_proto_csum_replace16 is called from many places, whereas this fix is applicable only for nf_nat_ipv6_csum_update, where we need to update skb->csum for ipv6 src/dst address change. 
Also my point is, inet_proto_csum_replace16 is updating skb->csum for change in udp header checksum field, but that is not complete. So, I added a new function. Basically, I used a safe apprioach to fix it, without impacting other cases. Let me know other options,  I am open to suggestions.

More importantly, I hope this is clear that the current code does not update skb->csum completely. Which is a bug. Thanks again.
