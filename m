Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5B2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKwm/tKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfGaSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:02:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35660 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfGaSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:02:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so30822089plp.2;
        Wed, 31 Jul 2019 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oaDZjxG3hf3XfIhJ0wNeSSq3sNs3Jdwm87Y90Lg53os=;
        b=SKwm/tKUjPhh7Ots6DumW+369InP9Y2lmV1wmGybkCv0R6omOv37Uq47RXnIirIKia
         opq8eRugeFtK7GjZou9O9XXyWH6xG8wQKJrm8VSBkDjeAeZd7tVNOdiN2FRBMB5v8ZAl
         wu+t+Jw9he5Id6CUsfAZo1ka5O7jl3A6JQT+Cxb9MRWbSOLDiBIzDKtZEeWLOiMrxS7H
         J/HZ7dbfGeZZCbYKu/XA+KgO8X9yyU23bzKjgizRsFw9qoY5zELut/2+3baGCSgZjZ+i
         XkoMqMGJ23aGab01Aws21ufDI6ctzimNBp0sOHAoQfhn71lZvFH6QPjrREDYhCjgE16y
         jsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oaDZjxG3hf3XfIhJ0wNeSSq3sNs3Jdwm87Y90Lg53os=;
        b=YtviM132S+9I6fy8YeCPnhmDrv0y68hwTwYuZSMVFjb5D/WRSw2DSHNL6GB5HVMAbX
         NUkFM3I270G3UXuo/RYVcDBLS9FavjyGAIrHlzOHB94BQaOy+K8w18JbLd8cyzW5+OeH
         nfZxg80ujuEtnMZblygsLn3ZlXl2HeW2b41ZuJCtJHJjcErSwqAbQgAHD5JrWpu03YhV
         7Yn1MWnsf9l7Dpfrsakqf4x06fvpay4xtVxLvWr6blCei5mPgsv+JGF0EZoVhJcZRiKq
         JepFTdU5vh8W1hwjBCs/WfvyrvKZGZ57GSqVmEP52cP4wujBa3w0h9MnPiXlLEVlh2sU
         B03w==
X-Gm-Message-State: APjAAAUG0LV2R58psdKv4TAkJSKITLQs5XZNAqHLrBaX0OQrnsp1y61w
        S4Sagvs0KX8u4AreTgwNzMc=
X-Google-Smtp-Source: APXvYqzzGoe74Mz7GNUOaB6q/Km/WB4j0N1VMsCqKCyLVSFJnrP7Bn9v2TTLduZOyynn180hJB4tgA==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr122219821plr.68.1564596119868;
        Wed, 31 Jul 2019 11:01:59 -0700 (PDT)
Received: from host ([183.101.165.200])
        by smtp.gmail.com with ESMTPSA id a1sm19789624pgh.61.2019.07.31.11.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 11:01:59 -0700 (PDT)
Date:   Thu, 1 Aug 2019 03:01:49 +0900
From:   Joonwon Kang <kjw1627@gmail.com>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        jinb.park7@gmail.com
Subject: [PATCH 2/2] randstruct: remove dead code in is_pure_ops_struct()
Message-ID: <281a65cc361512e3dc6c5deffa324f800eb907be.1564595346.git.kjw1627@gmail.com>
References: <cover.1564595346.git.kjw1627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564595346.git.kjw1627@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recursive declaration for struct which has member of the same struct
type, for example,

struct foo {
    struct foo f;
    ...
};

is not allowed. So, it is unnecessary to check if a struct has this
kind of member.

Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index bd29e4e7a524..e14efe23e645 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -440,9 +440,6 @@ static int is_pure_ops_struct(const_tree node)
 		const_tree fieldtype = get_field_type(field);
 		enum tree_code code = TREE_CODE(fieldtype);
 
-		if (node == fieldtype)
-			continue;
-
 		if (code == RECORD_TYPE || code == UNION_TYPE) {
 			if (!is_pure_ops_struct(fieldtype))
 				return 0;
-- 
2.17.1

