Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F88C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67D120659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYQB7geP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfJMTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:30:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfJMTae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:30:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so9102125pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=p7Dz6bQsOtxwdSt7zSmj/uP5LuPAh+UARfeVF8lx2MU=;
        b=dYQB7gePq8EFiXG3hLI0YW2woMfmiAWYdqxgvQ1t1E4HAmEg3MDiJC7gBOwgwTUw5/
         BkJ7kKa9+ioVMhxF5UezuGMfMGv5COjfBCYU9rT1pdE52CJ+pPKaFbKvwBPxeGuAH0EX
         qUNaaOrwB2K0k4sc3wuAGGl1Sq1iQ8W0fP4YKiIeQ+ig/iJi1jpvKbQm9/B7as3AX6KL
         LkJqVoTUQLMWDgpI/itwsCz73ZwdENr5PDDloNIrnTEpzpEI5N8L/I8PKItAE9U/8iyw
         jd+jqD7ek2KFgrbyRrTY5qNrQ06DXtqPxKpXq2RoYVIu+zicPY3DHNcwN3Qv5pZfbWAY
         xGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=p7Dz6bQsOtxwdSt7zSmj/uP5LuPAh+UARfeVF8lx2MU=;
        b=VnNg/lWVVVxC8e8NKmwhtIrZJTZrQ3zHx4hvQNxGiOIfGOELsuJ+5lIBWmtqMoz1qB
         mNqitamQdgLjhXz90i9UONX7nj3lORjzzzu8Dvxde8vU0V1/g8vJLkU0UbWB2X5E5KWI
         reFNC6GBP2R6hQ4VIgHb7IEpSqcAlvcsYBDRO/5T6c3NQOUShmoveddwjX65s0zTx2gs
         Z40mfMVOeP9+SujW6ihtaxUdT3rfvv/wqiRDF+V7TJJa2EqMnUtoPSRHw9iVpmEezR2q
         rWBo+zUHWGGvrxlPCCq8CTSPAbIBUU5HEGEPffLuByNaIuTbWLS4mVYeUyjK8lhiZ9gT
         DBYg==
X-Gm-Message-State: APjAAAXTK+zDJ+320oh1CMORH4G08poRIyBnnx6mehDkEofh1YoaU8i2
        TSawX+QMMLkwU5u05APwiG52lg==
X-Google-Smtp-Source: APXvYqwZ7lv21Vwa6UDYhqt4c2+s0JYiZnwPWnmhvcMzwmiJs/YB2oiyYc1M0HeiYulOTaYjBv8rdA==
X-Received: by 2002:a65:68c2:: with SMTP id k2mr29118453pgt.241.1570995033411;
        Sun, 13 Oct 2019 12:30:33 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l72sm21031601pjb.7.2019.10.13.12.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 12:30:32 -0700 (PDT)
Date:   Sun, 13 Oct 2019 12:30:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yu Zhao <yuzhao@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: update comments in slub.c
In-Reply-To: <20191007222023.162256-1-yuzhao@google.com>
Message-ID: <alpine.DEB.2.21.1910131230180.245225@chino.kir.corp.google.com>
References: <20191007222023.162256-1-yuzhao@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Yu Zhao wrote:

> Slub doesn't use PG_active and PG_error anymore.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>

Acked-by: David Rientjes <rientjes@google.com>
