Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB9AC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3A222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hiq3Knxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfJDQe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:34:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41909 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJDQe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:34:59 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so14825111ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SGqM+3yKbVJmLVuUUp3b6/LD0hJ2CQ/5lAjad49oZfs=;
        b=Hiq3KnxjgCoa7fM42jZ/eJ7L6fmoeIQsqkBW32bReVdq+5p5AMheZkYySQREJ130YM
         LytbMVn1ZAdjZ3CuzAT0xI1zwzWOI89rXTaH35Mc+JeVZLc6go+PkppN7must3ymhVNX
         GYpAciN94+YbJawhB0Tww6XV4OLTpb/ZhVdm4TBlRlTD0reAzbIWhLZxCqQKV6rxhpc4
         cVrG+DB9/grXkk2CIUbarQ5uizb2Je7f1k2d4vyGfN3lepxarBArpurz/GG7GsSd7izP
         W2QiXOrRhPizCd0rZ9MnDhLG6w2uRZacUV7NJ3vtE+FZzakXWjBloxwHtTlj6FeapZpA
         rRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SGqM+3yKbVJmLVuUUp3b6/LD0hJ2CQ/5lAjad49oZfs=;
        b=jUkvqIEXT+AdXU2UNV9ZHRrlwcxFsIE+M9z2S6mEUoO02z5XS1zD55bpm3gnaeeQ7I
         2nl++ksRgC71nautqBIA1iHXJ4rgf2Z70tp7NeGOoHKV3fHsdwgt3aL1xJ8IiQOX7R0N
         CENoJAcN+2Tu/gW6lPZyiRfbcftfjv5L2YqezNLk0L+4FvCmCUnPxZse/BZf07br8gFj
         EHIc1vyogyKV83YomzZ26dzJrBsjzVx7HkJuuGuQuUEsurYBoEHt9rHZrixRbFyPxxSI
         GDHo/Jir8GWMpAkWvRBe1Ggfzz9Bp5gTo6MStakqVPlITV8Em+Cc5eH6xfRm2EGGQfkM
         nvJA==
X-Gm-Message-State: APjAAAVbLOw7qAFuirztgY474ags21Ccj8ov9Iyo6bhtNX6+JRGWYnIR
        KusNIToF8QFGJvogem2B5cDbfzN7lnt3IKXznz8phQ==
X-Google-Smtp-Source: APXvYqy3ZAxCYueRwp6jwND+zik8W1OIH/2S/kqrX3mVWekZw9RcfVxwvG/7PBgjpCQlVTEiRlJTLW5rN4egcQgQXUU=
X-Received: by 2002:a92:cd45:: with SMTP id v5mr17338504ilq.197.1570206896657;
 Fri, 04 Oct 2019 09:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <157016600217.8022.346317009413291058.stgit@devnote2>
In-Reply-To: <157016600217.8022.346317009413291058.stgit@devnote2>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 4 Oct 2019 11:34:45 -0500
Message-ID: <CAJe_Zhdq4sFGgv-CJf12_qJzFq+oASTmsD8xReX877V1NYSCBw@mail.gmail.com>
Subject: Re: [BUGFIX PATCH] selftests: Use real temporary working directory
 for archiving
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 at 00:13, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Use real temporary working directory for generating kselftest
> archive.
>
> tools/testing/selftests/kselftest directory has been used for
> the temporary working directory for making a tar archive from
> gen_kselftest_tar.sh, and it removes the directory for cleanup.
>
> However, since the kselftest directory became a part of the
> repository, it must not be used as a working dir.
>
> Introduce mktemp to prepare a temporary working directory
> for archiving kselftests.
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/gen_kselftest_tar.sh |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/gen_kselftest_tar.sh b/tools/testing=
/selftests/gen_kselftest_tar.sh
> index a27e2eec3586..eba1e9987ffc 100755
> --- a/tools/testing/selftests/gen_kselftest_tar.sh
> +++ b/tools/testing/selftests/gen_kselftest_tar.sh
> @@ -38,16 +38,16 @@ main()
>         esac
>         fi
>
> -       install_dir=3D./kselftest
> +       tmpdir=3D`mktemp -d ./install-XXXXXX` || exit 1
>
>  # Run install using INSTALL_KSFT_PATH override to generate install
>  # directory
> -./kselftest_install.sh
> -tar $copts kselftest${ext} $install_dir
> +./kselftest_install.sh $tmpdir
> +tar $copts kselftest${ext} -C $tmpdir kselftest
>  echo "Kselftest archive kselftest${ext} created!"
>
>  # clean up install directory
> -rm -rf kselftest
> +rm -rf $tmpdir
>  }
>
>  main "$@"
>
FWIW,  Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

--=20
Linaro.org =E2=94=82 Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  -
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
