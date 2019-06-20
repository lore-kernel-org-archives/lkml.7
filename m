Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63020C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D562082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPdPtGZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFTUrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:47:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45976 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:47:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id k35so547790pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O7l+Vz8Z+P5e/XZWrPOY5NRWsmIcQSKPNpkfC3vTPbA=;
        b=LPdPtGZm3Cn4AH88lhL8O5Q3ngb9omPQ6UlcQz+FUPIDjiuAqz0J341JuPnNaUYkSQ
         /2WDq945SjNbhP0UH69dhcavWBJUFj1jh+R5LOnEc7xa2Rsfh3bWsYu5uurPZzBwV32R
         Wie2iQCTYHkHjSE7VCDn6rzndnvldaDH5+Hvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7l+Vz8Z+P5e/XZWrPOY5NRWsmIcQSKPNpkfC3vTPbA=;
        b=P1PplnCfneL5e2hbNZcAZhVLb7B0OVaf3tntClZpnrO/zegJK+fxActrRU0p2HB8B2
         69DobWsKaDI3qEVma0ZLMMTyvC697vvxgWf2abTzJgJDWL+yA+m9hQNiGiGkWiBszNi2
         lopTVD8cBbEillYJ8CRNCf2Woc3RWRK77rkJ4YnDtpcYuZGvlfrJnWZVhjLoQZJE+vOP
         CQkknQPl8rErl8OtkezzilTIckce+S9L2I3uB3wgbyE1LtP+iMO6OfxTfkD5tu6+Kiio
         UfIWOzhFAvIfW6B4qG87AOHli8GSiBs0/Pwb/1EPfXxWy2mlvQ5rvfCx2+oBI7LwtSDQ
         BMew==
X-Gm-Message-State: APjAAAX+ifM4XckOzIBBaoR3IOpyOd685RokCihdbDG3unJJWjm1uAZB
        PcobcHDzFqPzHNsvGac78KMaIA==
X-Google-Smtp-Source: APXvYqx5GZWgd48a6+yKfnLbweOOJhEBeIBAGntj/FOqK0vjt6TATda1inqr3cAGAltTTmAiF918jg==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr1639575pjq.134.1561063623898;
        Thu, 20 Jun 2019 13:47:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f15sm564455pje.17.2019.06.20.13.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 13:47:03 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:47:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tom Roeder <tmroeder@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Hughes <tomhughes@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>, Yu Liu <yudiliu@google.com>
Subject: Re: [PATCH] gen_compile_command: Add support for separate
 KBUILD_OUTPUT directory
Message-ID: <20190620204701.GX137143@google.com>
References: <20190620184523.155756-1-mka@chromium.org>
 <20190620192345.GA133204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620192345.GA133204@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 12:23:45PM -0700, Tom Roeder wrote:
> I can confirm that I can still run clang-tidy on the kernel using this
> new version of the script; it generates a version of
> compile_commands.json that works in my case.
> 
> On Thu, Jun 20, 2019 at 11:45:23AM -0700, Matthias Kaehlcke wrote:
> > gen_compile_command.py currently assumes that the .cmd files and the
> > source code live in the same directory, which is not the case when
> > a separate KBUILD_OUTPUT directory is used.
> > 
> > Add a new option to specify the kbuild output directory. If the
> > option is not set the kernel source directory is used.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Tom Roeder <tmroeder@google.com>
> Tested-by: Tom Roeder <tmroeder@google.com>

Thanks!

> >  scripts/gen_compile_commands.py | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> > index 7915823b92a5..5a738ec66cc7 100755
> > --- a/scripts/gen_compile_commands.py
> > +++ b/scripts/gen_compile_commands.py
> > @@ -31,15 +31,21 @@ def parse_arguments():
> >  
> >      Returns:
> >          log_level: A logging level to filter log output.
> > -        directory: The directory to search for .cmd files.
> > +        source_directory: The kernel source directory.
> > +        kbuild_output_directory: The directory to search for .cmd files.
> >          output: Where to write the compile-commands JSON file.
> >      """
> >      usage = 'Creates a compile_commands.json database from kernel .cmd files'
> >      parser = argparse.ArgumentParser(description=usage)
> >  
> > -    directory_help = ('Path to the kernel source directory to search '
> > +    directory_help = ('Path to the kernel source directory'
> Minor detail: this needs a space after "directory" so that it reads
> "directory '". Otherwise, the output doesn't have a space before the
> parenthesis.
> 
> >                        '(defaults to the working directory)')
> >      parser.add_argument('-d', '--directory', type=str, help=directory_help)
> > +    kbuild_output_directory_help = ('Path to the directory to search for '
> > +                                    '.cmd files'
> Same comment here: this should be "files '", with a space before the
> ending quote character.

Ok, I'll wait a bit for it there are other comments and send out a new
version with the spaces added.
