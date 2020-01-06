Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA56C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B562207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFluuYOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAFTnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:43:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgAFTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:43:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so50981628wro.9;
        Mon, 06 Jan 2020 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to;
        bh=3agK+krrH1Z+I8WdgHEmrcnhNd69YzO2FgoakpXdIM4=;
        b=QFluuYObY7vGlnLLw3uduf9rETAML7enawTk8MKTszjUcfg1qD3RwXhKMjcocQsex0
         +VtDbBsDL5C0ihjYtZlqurqwQXCc8SdmvcJzv1ZO719VrQKb6jyuOK06WFtNNBK+tL8x
         wneirxeq5LUUJs+96/BbRurp/9RJoM1GgkZl25JPxkW9sge99uHeWkiuby6JbpRjPPKw
         eHuTpKv6aqTmmKZfH3Zrzq7I5g6zAZeArxEU5zDtpsbreH7ijxzOI9hsaXv3pGFz3rYo
         tyJEF9Q2enbO4+gT6z501AMy6OL270tIq+JXyWtpprX7gGrGqtUMz8hAERCiJKXx0m3V
         Skrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=3agK+krrH1Z+I8WdgHEmrcnhNd69YzO2FgoakpXdIM4=;
        b=V98fP40lLt1OVVFt6oAi3L02Q/Saby87cgJLpHC6OSUO2MJpIH5tYNLHci0vHJx2fe
         iE88V2lBgUv1FT13jHEvmgb3/A4C3l6jMNyWSzQQL2ljS+REFLPd4AGCA/CqM6M9emFv
         HZ0v5SHKoORwxlGdC19FFhU5Yv77JERVg68cDxdENVfqqlD27oBGWeu1Je6OWLwhMyn6
         Wcx7WzZk3PxoCst0jDFON1nohWVvcYK61RN+BN4EJYbnOUMFVPQIjp0S90H63c1Rng1c
         1R8mXzZdh+Jo+YiwIXDa//sVTDYW9isUVp3Pi2GUby2PwfHoPIWPSHFr4rySiiEcpruV
         2MHQ==
X-Gm-Message-State: APjAAAU2QRu2Vw3zx+cfTNU8pc+eSIkWHCuHP1hM8xRX5EJ+zd+DD6Gs
        xSbtPb+TFJY7CwpBnh+lEUI=
X-Google-Smtp-Source: APXvYqxErxW1fHoZLV5x7CfY7Q600YRv+7IqD60lqlLPsRZpbDgjSbDF3Tadf3HpSDFeZ00pvqNTsQ==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr101664797wro.195.1578339821034;
        Mon, 06 Jan 2020 11:43:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id q14sm4035075wmj.14.2020.01.06.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:43:40 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     sj38.park@gmail.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, madhuparnabhowmik04@gmail.com,
        paulmck@kernel.org, rcu@vger.kernel.org, sjpark@amazon.de
Subject: Re: [PATCH v2 0/7] Fix trivial nits in RCU docs
Date:   Mon,  6 Jan 2020 20:43:30 +0100
Message-Id: <20200106194330.24687-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
References: <20200106191852.22973-1-sjpark@amazon.de>
In-Reply-To: <20200106191852.22973-1-sjpark@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Author email (sjpark@amazon.de) is not applied to this patch set mails...
Maybe my git send-email setting is somewhere broken.  Sorry, I will correct
this and send v3 soon.


Thanks,
SeongJae Park

On   Mon,  6 Jan 2020 20:18:45 +0100   SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset fixes trivial nits in the RCU documentations.
> 
> It is based on the latest dev branch of Paul's linux-rcu git repository.
> The Complete git tree is also available at
> https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v2.
> 
> Changes from v1
> (https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)
> 
>  - Add 'Reviewed-by' from Madhuparna
>  - Fix wrong author email address
>  - Rebased on latest dev branch of Paul's linux-rcu git repository.
> 
> SeongJae Park (7):
>   doc/RCU/Design: Remove remaining HTML tags in ReST files
>   doc/RCU/listRCU: Fix typos in a example code snippets
>   doc/RCU/listRCU: Update example function name
>   doc/RCU/rcu: Use ':ref:' for links to other docs
>   doc/RCU/rcu: Use absolute paths for non-rst files
>   doc/RCU/rcu: Use https instead of http if possible
>   rcu: Fix typos in beginning comments
> 
>  .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
>  Documentation/RCU/listRCU.rst                  | 10 +++++-----
>  Documentation/RCU/rcu.rst                      | 18 +++++++++---------
>  kernel/rcu/srcutree.c                          |  2 +-
>  kernel/rcu/tree.c                              |  4 ++--
>  5 files changed, 21 insertions(+), 21 deletions(-)
> 
> -- 
> 2.17.1
> 
