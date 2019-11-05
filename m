Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3B5C17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CBC21D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFSQHUs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfKENDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:03:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbfKENDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:03:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id i10so578618wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/s5wafhGFEmeVp2q9qS2/JVNnzuRPKRUizKrozNN5Y=;
        b=iFSQHUs82aEbQEB6EfeIqr/T1WNZtN1SpLjJu8FcIz4S4wpxeu0moCaqUVSoE+z2NN
         OGMjgELCTIIyNu3nAzIK5jJFS4SxfFft+RyzhJg2k4bAwzSJC6SD7FVqtBfj6bSOwPic
         IrE9Z3ANBgknzQzrdswK1ZT8ozJ1m+8A7isLpfsxCONG5Ea6WJDemtUWc4+Xl9baa0QM
         BxrzdmgKMtNbl6RS6721so+JuWw1uXpkgNf91EnSvu1kY9XY6huz/jSzD851MQzIJYZd
         oWZ+wq593jbaciPt3yDMjx4Lsa/OJIz16BELsSsjO4VStAWzJhIhTbdrQSnXXQcNR/NT
         +Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/s5wafhGFEmeVp2q9qS2/JVNnzuRPKRUizKrozNN5Y=;
        b=DHXfPeFXRjzTnELBfu31px/KPwv9m79RwDiM8UXg5yU6AaKb8/MTuRKsyLCCKPysg2
         IjXt7KD8Ez+r5hRzpQDRJxeZ+O9bVgGq8xytW7ljF9RvpjLNgy/zDxOeDKiBLhb7Qjid
         tZ1sHi/seRuIopFNIy8FIgdcG58Tq6Ny8yYheWFuRF+LehAgMk5I6+QkonhKZYnT0G5Y
         9kNqTUlf/zqeJFb/glJPZ7Rk+v29U6/n6/qWbac1bokaxvCgUJspfsOpO9LQHis2DSjS
         Fz9h+etHp0xTAJIXnkH5DE6zBkn8eo3ljqPtj5J3+FPc8GK2kTNUYCCfJggRZo8lH6VZ
         W/bg==
X-Gm-Message-State: APjAAAUwzotRJpnfi076bCW4FLxwVC138CMZ5aGh6pX5SpbQeqOv4bvq
        hdsEDpZZjdufhRhnAB9GMeziHjuDS7Y=
X-Google-Smtp-Source: APXvYqzMMcUwTcn2d9lJX0QQWeVy1GlIgb7tf4Z4MdKKLrPrIBwVyhIWlathYDBTAK2HeTEMFmsmvg==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr5290945wrw.82.1572959018197;
        Tue, 05 Nov 2019 05:03:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id w18sm12741193wrl.2.2019.11.05.05.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:03:37 -0800 (PST)
Date:   Tue, 5 Nov 2019 13:03:37 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] scripts/nsdeps: make sure to pass all module source
 files to spatch
Message-ID: <20191105130210.GA65671@google.com>
References: <20191105121103.31200-1-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191105121103.31200-1-jeyu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 01:11:03PM +0100, Jessica Yu wrote:
>The nsdeps script passes a list of the module source files to
>generate_deps_for_ns() as a space delimited string named $mod_source_files,
>which then passes it to spatch. But since $mod_source_files is not encased
>in quotes, each source file in that string is treated as a separate shell
>function argument (as $2, $3, $4, etc.).  However, the spatch invocation
>only refers to $2, so only the first file out of $mod_source_files is
>processed by spatch.
>
>This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
>get inserted) when a module is composed of many source files and the
>"main" module file containing the MODULE_LICENSE() statement is not the
>first file listed in $mod_source_files. Fix this by encasing
>$mod_source_files in quotes so that the entirety of the string is
>treated as a single argument and can be referred to as $2.
>
>In addition, put quotes in the variable assignment of mod_source_files
>to prevent any shell interpretation and field splitting.
>
>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>---

Thanks for fixing this!
Acked-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias
>
>v2: put quotes around mod_source_files variable assignment as suggested by Masahiro.
>
> scripts/nsdeps | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>index dda6fbac016e..04cea0921673 100644
>--- a/scripts/nsdeps
>+++ b/scripts/nsdeps
>@@ -31,12 +31,12 @@ generate_deps() {
> 	local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
> 	local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
> 	if [ ! -f "$ns_deps_file" ]; then return; fi
>-	local mod_source_files=`cat $mod_file | sed -n 1p                      \
>+	local mod_source_files="`cat $mod_file | sed -n 1p                      \
> 					      | sed -e 's/\.o/\.c/g'           \
>-					      | sed "s|[^ ]* *|${srctree}/&|g"`
>+					      | sed "s|[^ ]* *|${srctree}/&|g"`"
> 	for ns in `cat $ns_deps_file`; do
> 		echo "Adding namespace $ns to module $mod_name (if needed)."
>-		generate_deps_for_ns $ns $mod_source_files
>+		generate_deps_for_ns $ns "$mod_source_files"
> 		# sort the imports
> 		for source_file in $mod_source_files; do
> 			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>-- 
>2.16.4
>
