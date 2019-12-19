Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C74C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088E8222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzwiUU2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfLSTCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:02:30 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43012 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbfLSSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:49:29 -0500
Received: by mail-qk1-f202.google.com with SMTP id f22so1196549qka.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 10:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QvAStn8TBlGPLBczTd25Iv1mJFk80FYATk+vMJdp0y4=;
        b=CzwiUU2ZMCKcLRSu8XQzid0mJM78vsAjP8tuqj0HQuCCmaASulyFwyNDJlWGoosroj
         1fO4Wsaycbb3TicTzXWqFtSTqPoPoQOm26MamsOm4rg+esbFEOwyWlE6IV14U8O5Wg10
         PQyGxDvrxQ1EbcJD21HPrL6wSCYqbpnFGOIv0SBuo2QZgvuD4KpgNKTdgUZ3SnQ8Wd8r
         /gRd8R7oRg1ZmgfxBWtzuhIJJmWzYKEha1r6aJeZho6rnSfDBRoDGH/WzXFSalQ0XCho
         mHFn2l3155HhsgpwCqyyxeSM852qC9D3IOYqQO9YE8ob5K78vAlpDct/eM67LDYDBjRu
         pjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QvAStn8TBlGPLBczTd25Iv1mJFk80FYATk+vMJdp0y4=;
        b=Zb2bytNiC1WY4w8HHLQQQu60gpfxWaNVww9/vXrXdDOGok0U+ShwQePZo+HZJs8Vif
         utP64Mcl6ygCpMA3mXGW9IgriknPOWTDCUJ5p8chelV7PhS+K4kLkGK/kG0xQ7nEfbyu
         uCr4tMlSLnFVohDJgQaN2IYa8wa3BdDd04wCiN+RHOj/tq0N9QF+1NFGaKY85FS9jdXy
         +rD5Bcl70n2W80FQY/gCbNnLa2xMqLnV7NGv5WwLTDeksjJ2GSU42N+/28HiaK8XKJVQ
         sEUE5ZpPNMhgxcOQDDxKX3U1RlZ7meA9cIMygWwEHxfqLW/Ax1AU8c2f3KxzCk16uVyd
         oIQA==
X-Gm-Message-State: APjAAAVmecLkhqyNVuXPgRS14uQLNvzJ/0U/WUQmiY6Tb7eY8on0vXHl
        hQ52i5r/DfVXvKHd2KNPkn6TbnzFU4+x+Nr2Zz8=
X-Google-Smtp-Source: APXvYqxBHQnZ8CGo+nTRD2vQCKeO9gRgt8lGBRpC+p78kO93i8LDJrJzcWT7w8MJOaC0ABK7FXngW9PNnyvbNdWs5Do=
X-Received: by 2002:ae9:e304:: with SMTP id v4mr9534945qkf.399.1576781368073;
 Thu, 19 Dec 2019 10:49:28 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:49:24 -0800
In-Reply-To: <20190808123942.19592-1-dsterba@suse.com>
Message-Id: <20191219184924.105306-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190808123942.19592-1-dsterba@suse.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: Re: [PATCH RESEND] fs: use UB-safe check for signed addition overflow
 in remap_verify_area
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, natechancellor@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, looks like this kills two birds with one stone; both observed signed
integer overflow and -Wmisleading-indentation.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
