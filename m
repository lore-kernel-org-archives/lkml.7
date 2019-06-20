Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6230CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE982083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 19:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHGHcHQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFTTXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:23:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32945 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfFTTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:23:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so1790000plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PbqY6JxYtRflT8VXBrZuI2k7SBuVCB7vKDf/rMKPrA=;
        b=MHGHcHQrQsuQfe3jUNK1WeU21v3fsHqkh3H5MuygqvthK+Ib0xua03oAnMOlMqOyQS
         6uI2leF5kP2xtXwijlnVSeUYkvZ04DoFcdSQX4e4BHe4nw66ldwJN2SU0kZ4z+yWwSwK
         cQeIwp/92O/lc/D1hRPH8sGB5tkRnjoS2ho/BgUs9AO6x4J95ElOBg1wgEr6RqJ8iN24
         +7a+KQx58Qok1htiavsR4e3CmPTqE0HRSYbEYh9YzLzFRG9yZBkN8Hfu+3tDNPlw8RGl
         dQK2tu1ASXOID/dmTxVte784bTiEgRvGbBRmjxVUY+M/NaIIUfyxZlTEWDp65GyNVE9z
         agfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PbqY6JxYtRflT8VXBrZuI2k7SBuVCB7vKDf/rMKPrA=;
        b=G8zyyE65QHSInP7zpezJyaDBlkM4ga8J0hNOCo0Xm1diNSJuG0BHwCrL6wEtoXSbJu
         5J3Vts9n6auvpYhlyMuUqzox+7j17ktgxsNpAyLrikIrqCnCM0IHQVlY8WuQFr8f1U8x
         KHO/c153yPwh1CyQde+7GCvUIzW7XhfPA3JzxnOOWF12lxhKMtvkySAmQHQQuowowcV4
         NIVeFv8ek+pO5xs8OSHYzJcLmw/LRkCY9iP+0XbzaP/IwZNmUaT8kUxw3v8X/6J3ITFy
         uQD5af+BFpFuLW6F30NlpSw2PhFkVCcFKgvv6BnaJPiLFjjpMSSJiz8+1ojUWdGR5NdF
         6rng==
X-Gm-Message-State: APjAAAWRe0zpdDs+N8ZqWFz++TeOd0ftr48TtBrhpZTyTYSAL5BlOL74
        QMRN7yNanKG5XUgoClIA4iWFGg==
X-Google-Smtp-Source: APXvYqzZRj1kYSOSBJIhz4HEPMPf5ao3DjHA8FPKSfvGgbufGOyYbHc1nwyloJXYryrXlS3lv+zdXQ==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr101517249plt.263.1561058629064;
        Thu, 20 Jun 2019 12:23:49 -0700 (PDT)
Received: from google.com ([2620:0:1008:1100:dac3:f780:2846:b802])
        by smtp.gmail.com with ESMTPSA id k3sm375687pgo.81.2019.06.20.12.23.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 12:23:48 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:23:45 -0700
From:   Tom Roeder <tmroeder@google.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, Yu Liu <yudiliu@google.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
Message-ID: <20190620192345.GA133204@google.com>
References: <20190620184523.155756-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620184523.155756-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that I can still run clang-tidy on the kernel using this
new version of the script; it generates a version of
compile_commands.json that works in my case.

On Thu, Jun 20, 2019 at 11:45:23AM -0700, Matthias Kaehlcke wrote:
> gen_compile_command.py currently assumes that the .cmd files and the
> source code live in the same directory, which is not the case when
> a separate KBUILD_OUTPUT directory is used.
> 
> Add a new option to specify the kbuild output directory. If the
> option is not set the kernel source directory is used.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Tom Roeder <tmroeder@google.com>
Tested-by: Tom Roeder <tmroeder@google.com>

> ---
> Feel free to bikeshed about the option names ;-)
> 
>  scripts/gen_compile_commands.py | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 7915823b92a5..5a738ec66cc7 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -31,15 +31,21 @@ def parse_arguments():
>  
>      Returns:
>          log_level: A logging level to filter log output.
> -        directory: The directory to search for .cmd files.
> +        source_directory: The kernel source directory.
> +        kbuild_output_directory: The directory to search for .cmd files.
>          output: Where to write the compile-commands JSON file.
>      """
>      usage = 'Creates a compile_commands.json database from kernel .cmd files'
>      parser = argparse.ArgumentParser(description=usage)
>  
> -    directory_help = ('Path to the kernel source directory to search '
> +    directory_help = ('Path to the kernel source directory'
Minor detail: this needs a space after "directory" so that it reads
"directory '". Otherwise, the output doesn't have a space before the
parenthesis.

>                        '(defaults to the working directory)')
>      parser.add_argument('-d', '--directory', type=str, help=directory_help)
> +    kbuild_output_directory_help = ('Path to the directory to search for '
> +                                    '.cmd files'
Same comment here: this should be "files '", with a space before the
ending quote character.
