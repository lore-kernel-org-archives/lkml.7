Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD68BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746DE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SS8QhlsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfI0N1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:27:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39672 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0N1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:27:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so2750380wrj.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNt467bjIvSt08/aWAn+bMKdEYDxZ7VI+aG4QKW/Ir0=;
        b=SS8QhlsFbSgySwasFielrGCUpbW+XIEZ36+9/GNGk0+xgEK762GHttXzsjs2BlpRt6
         267URcUQie+Q6yqFOCWJPn+CB4Mqa4oaekmr7GKmz6blCxQfUw6Kvi8w3ILF6sDfMPYQ
         Z/ltC3UfKvcSdwHRog/1NbZIjyLzYoU4Z16UVEQP7Jz/0tVzuSrbjuepvO30d4gLY1Pc
         h6YH6hjg5ImT/vUtmLbgOSAQMlYVjV4tQYo/gQn0Zyv7z6/RnOj0HG7HNmwKDHVx0Osy
         bgcn7Bt/SBF+tEnTRZuAPRlWfkRFCNNmYHeRJdzY+kDG6S+u6QPXBxUn1XN38hfZhuXt
         Tg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNt467bjIvSt08/aWAn+bMKdEYDxZ7VI+aG4QKW/Ir0=;
        b=I6MjtLG8cZ3q63cqesJ5xsPyB8cKjQGzc6u90xAKMpLpLucoigogA465S+OK3G+/15
         Xbte6RVQh0BCILqc4zG3Kakri99CXW85srqb0pvc+v9w35KgnIIG1hLGLKEMJiqWg+lf
         oA5DBhly7VdMZ6rueLxM6ertS0TgeZfvQlZRWDVZT7pH0Xz893itmVkI4Q6he+1U16Mz
         leTvvP8v1E4Ots2BaltDqK4GlfQZUZQQgo0+phFQcKKSyTTxKN+Qgu+Z7R97WijyRgZk
         SRXu94sDmE/x00VdN20lB+z+I1CBHMx1hjxowtx0/LCnef66RjVMfbd+6SILHxFqIPkg
         FIhQ==
X-Gm-Message-State: APjAAAVEjohBVVUXC8fhjWOze0ndifnN/ECVmOZ/zmMmnyR8JW2IwZq6
        T0IQ8/qA/9md8gh75/KWtIRxsw==
X-Google-Smtp-Source: APXvYqyvvL5jNtq2kLAn0ca2T0cprDED1D5rP+9oI9IvcVYiAF1Eb2ihnBnC++BjCslJtfeWE1KJHg==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr3199010wru.227.1569590849969;
        Fri, 27 Sep 2019 06:27:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id r9sm3615870wra.19.2019.09.27.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:27:29 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:27:26 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
Message-ID: <20190927132726.GB187147@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927093603.9140-8-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
>scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
>tags, and what is nicer, it sorts the lines alphabetically with the
>"sort" command. However, the output from the "sort" command depends
>on locale.
>
>Especially when namespaces contain underscores, the result is
>different depending on the locale.
>
>For example, I got this:
>
>$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
>usbcommon
>usb_common
>$ { echo usbcommon; echo usb_common; } | LANG=C sort
>usb_common
>usbcommon
>
>So, this means people might potentially send different patches.
>
>This kind of issue was reported in the past, for example,
>commit f55f2328bb28 ("kbuild: make sorting initramfs contents
>independent of locale").
>
>Adding "LANG=C" is a conventional way of fixing when a deterministic
>result is desirable.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> scripts/nsdeps | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>index 964b7fb8c546..3754dac13b31 100644
>--- a/scripts/nsdeps
>+++ b/scripts/nsdeps
>@@ -41,7 +41,7 @@ generate_deps() {
> 		for source_file in $mod_source_files; do
> 			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> 			offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
>-			cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
>+			cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp

I would prefer to have this set throughout the whole runtime of the
script. Otherwise we likely see a followup patch. So, either as an
export at the beginning of this file or as part of the command that
calls this script.

With this

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

> 			tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
> 			if ! diff -q ${source_file} ${source_file}.tmp; then
> 				mv ${source_file}.tmp ${source_file}
>-- 
>2.17.1
>
