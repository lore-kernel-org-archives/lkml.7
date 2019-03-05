Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC34208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Onm1RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCEU40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:56:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43741 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfCEU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:56:26 -0500
Received: by mail-lf1-f67.google.com with SMTP id p73so6617423lfe.10;
        Tue, 05 Mar 2019 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WE0JkjBhL2D3ZwDI3KhHguSjafeFaOI1IIth7XaAq5U=;
        b=S4Onm1RDenpAoQv20D6kO8ovJbXePT5gbblV3YYnd2wy4IKwVpNZ293ZWD9ZahTJPh
         BjtW7znsMWz2l0YAgnJWh1S1I8CODtzdAFeQo1Vt10Blds18rW9z5VHKD/OsKG+0AQqY
         Z4D2mUak55vTSNdI4bfKX2NYfMIH8+VkCaYTS7rT2PGQxSGdUQjTkVHk6DjIM20nJ1wy
         i+4Q+IBh65aiBSYt1J3srcxr5syxvG3Mm9P+j425RUjmlvHEVxpBIHV9jA5shCbi3Wrh
         sVJ9ncEgqIQdk6oSivcCDCkoPp8gtyK/dogle85liIwQ4UgkA8gpOvgTjmGeqm4tcFkY
         qrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WE0JkjBhL2D3ZwDI3KhHguSjafeFaOI1IIth7XaAq5U=;
        b=O1+AIobj8BUxJG+hXHY3an636vrBuTlLrlDrHOSozwHTG89U4v2sVj+nOh7QWewmZt
         hbpLD2Q73JeCUL0eI6Gwq0klBRKrQaO8pN7Lie4S15Zv3I61ykkMUKehGymU/jrCYIl0
         /jfTsWnkQtCbLHP5Euzu2YVelTagVviOy1i/vxQDCDA2faOq1P42ih1/Rm9EKndj9N93
         oQ+eqcYNEb4U5Ipu9c6wc74/Ipvnh9b0JZ8ox7nNzCsha9bCVhIC7hc3wWKL4ebxIBmE
         OIwDFt6w12RSOAhTzR6nHMQfebn+c5IUatdvNFSUTZrwwz1+U0b9torlxbDxDaEdCtiQ
         iGcQ==
X-Gm-Message-State: APjAAAV0eNYevjyBQSAGY2DrvNyCfdd9QzEekqGAKclqJbKi9A3CXv3w
        IUkQ5/KRnJ9OHWAqBvs4tJY=
X-Google-Smtp-Source: APXvYqy29jLiIHUYtLqgV8EJpQYcmDXVGiEaQ/a/70crp6G+M3YK2JJEhdG0t4Mkpubs8+3KmXdr3Q==
X-Received: by 2002:ac2:4192:: with SMTP id z18mr1814838lfh.39.1551819383329;
        Tue, 05 Mar 2019 12:56:23 -0800 (PST)
Received: from localhost ([94.25.171.210])
        by smtp.gmail.com with ESMTPSA id s21sm524371lfc.53.2019.03.05.12.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 12:56:22 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Tue, 5 Mar 2019 23:56:20 +0300
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>, yury.norov@gmail.com
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20190305205620.GA3805@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:18:45AM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.
>     - Zhou Chengming's reported-by for patch 2 and signed-off-by for
>       patch 21 removed because his email became invalid. Zhou, please
>       share your new email.

Hi all,

This is the 5.0-based version.
https://github.com/norov/linux/tree/ilp32-5.0

Since 4.20:
 - all new files are consistently GPL2.0-licensed;
 - AUDIT_ARCH_AARCH64ILP32 added to let syscall_get_arch()
   differentiate ARM64/ILP32 from ARM64/ILP32.

Yury
