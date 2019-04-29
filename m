Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05039C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3CC2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="YLZR4RRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfD2QLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:11:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2QLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:11:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so16829827wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YLZR4RRdvy7GOQL3yIKY0tJpo8BpKiIefH/KT581FDUw9ircAzV6l9K7i+ONDZc5le
         amq4L4WVBnBdNZ5cCTOuLgfnbpTac+FbUaLdneDsQ36P/8gw1lT1uPV27ileqRlZ5HoQ
         QyKdN7+m9tDRYg8Mq5GkTdWAIt7gyahL6tbctlf06jv0ftSXf8Ut9NXD8JGQluVnUks3
         eFaJ+TrZvW4ss1W6NQkK2JwhkpD30EOAHqLRJ692CO1KMvjRAxbqi+wnzUYZWrGtpZDt
         sfcp/vNaFuTtxZDd6lbLUWMiT6xfzusZMCngdizXnwKdpGG/XwpyWNLWnb/fvoHpWhAC
         kkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=ZeWWo1ut8iuvcE5a5/4pv3VBV3dz3qF2EX5hDqGVQDUdXGE2tmKklsBD0aiZanT4Oe
         Tm1SzOfFDB1D5QT5upe+6jNW44bE2nOajjdWwSFcc39xjlUpZ0fWfUAp9iEtUusCddIp
         KeNbPyrWhraGhnuoy2aieKsrJeKwOxO+am/QX88vUsm7qcoQSYfuiFkoad/eJAa21DF7
         wM+76ukHT9H7HH9DlvSuujzaoOrJnS8RsnyqVr15TFfRWWemiJrngJsh9YhJdo2o4vE7
         86WdbelhehNMdLKW9ge7KUbOeVQXSJbqaVVR7r3Gn7s7+L6GSYjehli5lHctD+ulAgPV
         0gGg==
X-Gm-Message-State: APjAAAVA6Z82scR2gyFZkj3pClz6hk2jkOE24hpGdnb5yF/f97+/xzbV
        pE/i0RTKoSyRcaKlaSXuDvQNbw==
X-Google-Smtp-Source: APXvYqwtSafBfAyKmEgIfqkdJNea10a06Xv48yGNTivFVGLzR1chdqHNllOogUh/mhE6aFzZG6m/bw==
X-Received: by 2002:adf:eb44:: with SMTP id u4mr28211821wrn.83.1556554295649;
        Mon, 29 Apr 2019 09:11:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:203:9bb:78dc:3222:caef])
        by smtp.gmail.com with ESMTPSA id u14sm31668076wrr.1.2019.04.29.09.11.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Apr 2019 09:11:35 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:11:34 +0100
From:   Alessio Balsini <balsini@android.com>
To:     alessio.balsini@gmail.com
Cc:     bristot@redhat.com, claudio@evidence.eu.com,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        mingo@redhat.com, patrick.bellasi@arm.com, peterz@infradead.org,
        tommaso.cucinotta@santannapisa.it
Subject: Re: [RFC PATCH] sched/deadline: sched_getattr() returns absolute
 dl-task information
Message-ID: <20190429161134.uvgikvfg7rv2wkff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629120947.14579-1-alessio.balsini@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

