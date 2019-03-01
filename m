Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4868DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051402084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xk3kkXqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfCAS2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:28:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36892 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbfCAS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:28:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so11803373pfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djHAYEgW5Z35X6o6/JmdamoYrWVf1XxIzsMXRq9O6fw=;
        b=Xk3kkXqJGtDR/UPyjGmFdvCIJt0UZR3JSSHjgx/IEPp6gJoSwO2KTLxpb5aYbTk0rA
         VHY/B6jeX8wTYNco7xoP7WQgygAFzFY/3YPzdwCgRfTbTKMiP6WvViFubY2efUG/MliQ
         Noj54c2aLR2766RG9djZNrIV5x1ALEeCu6T/P5sEyHMz46SVahi+TbaxsYvAZ9vmkSYd
         6WbnK/VaxRrSH4MBXBZJ2RA246404dQ+jq4PnHKq92uiXPrI8P6qEDTQaW7hlxDpKCV3
         PhlCT8q95BhGm6zTpYK+MsPFfCBjz0u+mQ/fmyOZ8nqBvpHL5YAYiZXjiKqQwSWrbc42
         V3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djHAYEgW5Z35X6o6/JmdamoYrWVf1XxIzsMXRq9O6fw=;
        b=Mufa/ElW+7Es6WLYflBFvduVAq6vEXQjiHrN5j9Mr3fhklK+18G12Ut8nFUyjTXTUW
         urn1bpV3EkbvLePKJ8g/EDcZwpBWKW8Ip+gfB4GlUuzF0kSuYuEgMf1aHZ+rvJw6Dmcu
         JHYt+lLN4JbNBken6Dg8Ara9RhiRDKPRU9Zkrv7/zk9f/7myHZKPOLR392/0ZlQY/GIi
         UZp9vFzTi8Kv77C9+cvUZvfCVDDzvw90eofjRnYSeuFWFn03i2FZXPA1BuqzGD1uesYA
         I6+M0fkq199/o5gnWxQjKxuaeQ1QBWcX49iiXT+h77if0gePMiwO09gNsu7Oknpge8p9
         qtbg==
X-Gm-Message-State: APjAAAUP0kDSfqhCwCxC4eRr0EXPkJr3/jB9Gd1+4CK8cJVIDtpABYY6
        x8ygF9AQGsXwKFT9wcvNMTENu20LlD4r8Zl7lRfKJQ==
X-Google-Smtp-Source: APXvYqyX+ZJsWjBAKIr6NPF+YT4IABCVIqL0kt8W5UpUaizKWInVA+WfSe8VyaOp5mhrnzWCxFsh7BhBFEQu6B04JDg=
X-Received: by 2002:a63:c70c:: with SMTP id n12mr6249416pgg.302.1551464926158;
 Fri, 01 Mar 2019 10:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20190208050921.GA8758@archlinux-ryzen> <20190208143403.GD7035@unicorn.suse.cz>
In-Reply-To: <20190208143403.GD7035@unicorn.suse.cz>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 1 Mar 2019 10:28:35 -0800
Message-ID: <CAKwvOdkNv_HUREJhUdOgHBgmVghPvJUun5wYuknCfTO0zN5TAg@mail.gmail.com>
Subject: Re: Clang warning in drivers/net/ethernet/intel/igc/igc_ethtool.c
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 6:34 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Thu, Feb 07, 2019 at 10:09:21PM -0700, Nathan Chancellor wrote:
> > Hi all,
> >
> > After commit 8c5ad0dae93c ("igc: Add ethtool support"), Clang warns:
> >
> > drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: warning: variable 'igc_priv_flags_strings' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
> >                   ^
> > 1 warning generated.
> >
> > igc_priv_flags_strings is only used in an ARRAY_SIZE macro, which is a
> > compile time evaluation, so no reference to it is being emitted in the
> > final assembly. Is it actually needed and was forgotten to be used
> > somewhere or could it be eliminated so that Clang no longer warns?
>
> That's because the driver provides get_priv_flags() and set_priv_flags()
> callbacks in its ethtool_ops to allow querying and setting legacy-rx
> private flag but it does not provide get_sset_count() and get_strings()
> to provide list of private flags to userspace ethtool.

So the variable declaration should get a `__unused` annotation then
(and maybe a comment)?

-- 
Thanks,
~Nick Desaulniers
