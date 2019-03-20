Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE13C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975F72183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pl5M/KSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCTBPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:15:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfCTBPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:15:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so437625pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ECbyCNrL6POmMsnKOC7bnI3ZWNUdHYm5lLii4apClDQ=;
        b=Pl5M/KSgSIiqLFbRFRJNsQDB9iKle66fx9LX4ByieGMWC8SQBtyP2qVxGhltYS52eu
         Cu4JrGQBrPZ21Ba3a0BCPjvBHeuk8s0ihIkCsOiR1vweZEtF8v0RcJ3OGwZOuqCvdkfc
         8aUUsqwVl+eFU87Yt2inqjPTSGmqQv8Bvx6yFstigacWwF/9OzXquTDbu1KqUt7XTW1U
         +eUa/VfxDch+o44zrnfnoOPOJObGYm0s/0ZoAIboXUW84pMFAAeFOJAPXMoxqxf5+fWZ
         TfpLFNCnlqjCpiuxwrB+X0Y3mv6zHqa1bocwXzC2seg7CacojwvvykGFT7Z6oJkXzOgu
         xwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ECbyCNrL6POmMsnKOC7bnI3ZWNUdHYm5lLii4apClDQ=;
        b=s55AS8P+Ctjo1lAcJl/JdU56vV3CX/UUB2Mc5iNHlN4Tt/wHkkMhL+rafPsc2JWuop
         b4eiJ+Jxpbo7sQgd4z031qdnYdLYcg8QHSH5pQM6xEEKpImYjYPNrRFnDNBCLYFCXs4X
         PqikjeNhTXh3FTtCMRBP//K1tT4fLKDE17f6HblkeqviwEDEV1azlKAGiEKW2lsHTBLt
         +UMV9+07TucT51OGELdnBiWA0jfKIS1UNxfJgbYBYSRRfK8LG59d12q4dVxCfxMYjLaV
         Zs+8QriU4z7qVe2mK698rFPqjQqjWg7lLMecwfmwHG1u409eg1MgVXG/G6B9D0TGa6zK
         EjrQ==
X-Gm-Message-State: APjAAAWDtEQAI/mWOWX5kmOqZwQxGhSu0fHnY214qFAAaRgvXRkFebco
        bl6Lslk4ilAj/PYOkZyzFOVLiw==
X-Google-Smtp-Source: APXvYqzOiMaKl/du02ONuqlh09I6urwHFacOMjJ61ZMMBO06AiW9KIOBH0tP8AoBI73o/uTgZ0wGqg==
X-Received: by 2002:a17:902:127:: with SMTP id 36mr5139769plb.268.1553044517257;
        Tue, 19 Mar 2019 18:15:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h65sm253003pgc.93.2019.03.19.18.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:15:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:15:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Liu Xiang <liu.xiang6@zte.com.cn>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: Re: [PATCH] slub: remove useless kmem_cache_debug() before
 remove_full()
In-Reply-To: <1552577313-2830-1-git-send-email-liu.xiang6@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1903191812360.18028@chino.kir.corp.google.com>
References: <1552577313-2830-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019, Liu Xiang wrote:

> When CONFIG_SLUB_DEBUG is not enabled, remove_full() is empty.
> While CONFIG_SLUB_DEBUG is enabled, remove_full() can check
> s->flags by itself. So kmem_cache_debug() is useless and
> can be removed.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

Acked-by: David Rientjes <rientjes@google.com>
