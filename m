Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C2C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AB7217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McuGjFId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfEJEc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:32:59 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39825 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfEJEc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:32:59 -0400
Received: by mail-lj1-f181.google.com with SMTP id q10so3904734ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wXqDyT54eG8GjQFqXbx6hw1gB6u+wOkPmPcMAUJsUa0=;
        b=McuGjFId86StbKuSJ+yG6vZBhcf5x0htNqzcSco/SevsPlcGDmxOcy4FSf72jvpt0t
         h6mRvr4jGUlhWOdxsusCRsNHl/8BJjPVxCa8j7oUHVwJZw8Yhwr+AC4ApaGsKOY5l0t7
         0eGq3u+xp6nAYqMwSJRBqupNn/7EPARlhiCGxr+wBctmqoiRLoLU+cWJ+4PiNgi8vNIc
         bmKw4R26qSSJVvaHcjuGUKp7o7BNKbhvfFcEHTVT6SKib3MUBACb/Ek0ZIea39l0pnnY
         X0zcnyDLCv1Vh3oqigNKEkCmkR8Jo2w6NrAc1UfCOfE98c1FVc6baMdoG418kPCH7e3+
         oDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wXqDyT54eG8GjQFqXbx6hw1gB6u+wOkPmPcMAUJsUa0=;
        b=LVSMuIjKnYXN2u4orNGIsJ+e8c7wyZZSRxTYZs+66qzl75TEndoDpkyNDoR3yTuTcI
         dJLgrfXQpK/s6P81UIrlcRjbJywGcZWGYrrFcVcavGDVsZBEfbL6dNa5aT2CY18LQgvU
         igrzxvRF6EmmS3qK2LBCydOANYB+770Vd+C7gx2xwmutnrVFqUxjCjC9iMxG8pQQnc5M
         yng761446LWfdxW4rcXOuvfPwO5akk/12efqfwIA8xn8fXGyVc4N0eM33TxWWNabQdE3
         +x0L6FJO46lr2op/bR9Ec+8YgjelyP/RJodtSUlA9tOsoORVFR3nv8biGMMnP8WSQv1k
         9UHA==
X-Gm-Message-State: APjAAAXCtDbRUb63zo66UD7Tuu3liC4i2CKo5+DxYEU0iikGuu1behdx
        51GlJ7MM7Pe/D568Mn3W4peMZ9Oz
X-Google-Smtp-Source: APXvYqywVbPJkk/7SIVcABr8gD3o+8qc6lWM0Ajw2WMxdqxLcLgWCHkY4EK+acReNIVkZJw8YZfUVQ==
X-Received: by 2002:a2e:9583:: with SMTP id w3mr4480251ljh.150.1557462777485;
        Thu, 09 May 2019 21:32:57 -0700 (PDT)
Received: from rimwks ([2001:470:1f15:3d8:7285:c2ff:fe37:5722])
        by smtp.gmail.com with ESMTPSA id h123sm959243lfe.65.2019.05.09.21.32.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 21:32:56 -0700 (PDT)
From:   Rozhuk Ivan <rozhuk.im@gmail.com>
X-Google-Original-From: Rozhuk Ivan <Rozhuk.IM@gmail.com>
Date:   Fri, 10 May 2019 07:32:49 +0300
To:     ossobserver@redchan.it
Cc:     linux-kernel@vger.kernel.org, misc@openbsd.org,
        freebsd-current@freebsd.org
Subject: Re: Danish FreeBSD Developer hates jews collectively
Message-ID: <20190510073249.73a17721@rimwks>
In-Reply-To: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 May 2019 18:03:04 +0000
ossobserver@redchan.it wrote:

> Background: Apparently a FreeBSD developer, a viking looking fellow,  
> has been hiding a secret: just as many of his predecessors in the
> Danish cities during WWII (collaborators); He has a disdain for "the
> jews" collectively.
> 

Who cares!?

