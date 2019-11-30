Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80CBC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782B820725
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155486;
	bh=jAZgwlkFITn9guffx1lS7YNxtuHHSSOb49lbGPlxLGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ytFCP+cWWv2mxfKKiAWs021U6mlxmO5YJIp2yvQ47G4yQBUJB9COZd2XyGtCbrwqS
	 +JC3PCla8g06RVJdgFqLeJSsB/9COtXMWB0QvgeLHThgM0lIEJxfpccbVDoPPl9yko
	 3zhC0Q747QbMtzzkzCOp3WTX/rc8T6ZfXCDJs4Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfK3XLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:11:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41956 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfK3XLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:11:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id m4so35654040ljj.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 15:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYTY0n3QsHBqZOy36tonEndwNoj7tohoLo0ZADDmXdI=;
        b=gBaDTkp8NLxH62T6UURGOeViYXp6AKFU0DKORiZX14t7T4/suPUQTRa8CdMlMDdrNs
         4xC6JGRELDoDK9nlQaZgkb3NwDJQT7MrbGKx3/x156kwSIekaUnczLiAdIfHQZkXi+MQ
         U+YzULRrT+PXsMAHZCap3wQS93TGauVcU3Qg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYTY0n3QsHBqZOy36tonEndwNoj7tohoLo0ZADDmXdI=;
        b=EE4Nlqnjk7O5RtZXiX1x0IOv+fU5ye+WPvSRjom1Vr0+XSGVq+Y5cyKdeNUp2w98+N
         c0sCfgejbuZni9ZI6lMo9+nlosLCtTGWpgX6Ei8S189a9wFjHg1RkdWUKSFmSt+BpF3n
         AiDITC8pjoxJ33iF/YwVWdE8i/Ekx0XejKW5mZXs8WHBG6K1u0d0Tv5fe1E2CxM3P848
         5WXeOvKPYuCDl33uaduNPGg3odmFs2A34afDbTG6KKsHIoHIvFcTSwBquJ0NLh5XlR0Q
         NByd6oJM9bRWMQZmn7m/WlSYAuXJTiHf04yhgG6fDJgpC+xyu/FwyWmdmaeQB4gOH6Nu
         nzyQ==
X-Gm-Message-State: APjAAAXD+NlyNmY/6J1V2hlRBH19GFvyrC28bydty8SO4jfyOIw4xP8T
        6dmWTmQnz+b7ZP7GoAewnaydElUtBqk=
X-Google-Smtp-Source: APXvYqzevXOZKedgWG46X6c7ylkcNLJCZv/MwE5VrZA9iC80TW/g1d3IrG8sOZLGlQ5ro2gs+XOGWQ==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr38296310ljo.221.1575155482357;
        Sat, 30 Nov 2019 15:11:22 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s20sm1115297lfc.8.2019.11.30.15.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 15:11:21 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id e9so35659831ljp.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 15:11:21 -0800 (PST)
X-Received: by 2002:a2e:9549:: with SMTP id t9mr5158199ljh.148.1575155481093;
 Sat, 30 Nov 2019 15:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20191126093002.06ece6dd@lwn.net>
In-Reply-To: <20191126093002.06ece6dd@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 15:11:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
Message-ID: <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
Subject: Re: [PULL] Documentation for 5.5
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 8:30 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
>   git://git.lwn.net/linux.git tags/docs-5.5

You are doing something seriously wrong.

There are DOS line-endings now in some of the  patches, and I noticed
because I got a conflict in

  Documentation/networking/device_drivers/intel/e100.rst

where your version was identical to one I had merged elsewhere, but
had ^M at the end of the new lines.

There are other examples of the same in other places.

I'm not going to pull this. I have no idea what you're doing and how
many incorrect line endings you have that just didn't happen to
conflict.

You have some *serious* tooling issues. We don't do CRLF line endings.

You can do

   git grep "^M"

(where that ^M is obviously the CR character, not the two characters
'^' and 'M" to see it. In a good tree, you'll see

   [torvalds@i7 linux]$ git grep "^M"
   Binary file Documentation/logo.gif matches

but in your tree, you get an additional 59 lines of that bogus CRLF
garbage in these files:

  Documentation/admin-guide/dell_rbu.rst
  Documentation/networking/device_drivers/intel/e100.rst
  Documentation/networking/device_drivers/intel/e1000.rst
  Documentation/networking/device_drivers/intel/e1000e.rst
  Documentation/networking/device_drivers/intel/fm10k.rst
  Documentation/networking/device_drivers/intel/i40e.rst
  Documentation/networking/device_drivers/intel/iavf.rst
  Documentation/networking/device_drivers/intel/ice.rst
  Documentation/networking/device_drivers/intel/igb.rst
  Documentation/networking/device_drivers/intel/igbvf.rst
  Documentation/networking/device_drivers/intel/ixgbe.rst
  Documentation/networking/device_drivers/intel/ixgbevf.rst
  Documentation/networking/device_drivers/pensando/ionic.rst

and I have no idea what you've done to make it do that, but I
definitely don't want the end result in my tree.

                Linus
