Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AEF206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+bqH+BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCDSAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:00:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43307 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfCDSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:00:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id q17so3549769pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6myyJzks72PYbOylGqxUbMDE4mq9yu5K//MBRwXTF4=;
        b=k+bqH+BA4Dko5eAXXuVt6aY7bQVuU9zgfGjUj8Qm8e7c3fPLkODWTumhgG/qetTiP6
         2JcanN9Nj8PidpXH0KsUicT4Ur8YVy2Uiv+JySbXq8LJkUnl+TQIgZI6v5wAYngFseKM
         NirhSoWu+motriIKQT8d65dXedNguxrA9bLFH92siNzczTMpaE7E72XUovY0QcM8ixW1
         blnAJMKN5xXj8Ce91uTvyAWvZI/5BPBvgyAAv5NOmmmqSHmkKW5hTSNnNEbd1Qw8Aq/k
         HfeT+5xxstoxuE0V4EpAfIlqiKWzUfl4CHNM2dcrEU76EOBDdYg6E+aWsvadGmxSJ97k
         FcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6myyJzks72PYbOylGqxUbMDE4mq9yu5K//MBRwXTF4=;
        b=oxYzHP5Egtn35Lu1Gv2KoQY0t942q0blOhWyBSLOkx+FSKlbqlh63aStOImzJ4Jewu
         5/OdFTP8ZovSNJBS7bvOemF7+bw3S8pUVYIHPhOO85JZ0L3FQMfGCEFZlkJyqWdiLHMz
         kKmwsrJaxgoIc5VsiD8CMtLDYIb7h7+TE5s+VHeeK/F7IQpwdL1tWXPWXvJ5l2Wuw2zc
         JU2EB6Urjh5LyKjuSCarEjSj9Irg7T2E3A+y1ShDAwOTv88xdZNXp3oP3NMnlrJiUZoI
         Maw5161oi0JFAaub0Wlq7wATUUYkSqxDBiXmtauTqrjenTjP+Be4DiZ5tlcCSHoVLeat
         gjWg==
X-Gm-Message-State: APjAAAV2rUZkPFDowGnZn0+2obPN2Vfi5zbRWjkBXz2qHqvQPB35uUgu
        6ajbLc+gtUGmwyKUmbxXaZlesDqeX/y7DVQzr5k4sA==
X-Google-Smtp-Source: APXvYqy7wE/vJKPtFLSSXC5Fgp2RRF3rbBPQhKnrplxPYMJXatftBZt7zh9u68AFuZVtS7Nq1KUMnUaM+1yX4S4MGqA=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr18669506pga.225.1551722400102;
 Mon, 04 Mar 2019 10:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20190303123647.22020-1-louis@kragniz.eu> <20190303201016.GO9224@smile.fi.intel.com>
In-Reply-To: <20190303201016.GO9224@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Mar 2019 09:59:48 -0800
Message-ID: <CAKwvOdm4uCWCtSMVQDVTSKavpT0dCo+ayuwvoXtewmk+ksn5sA@mail.gmail.com>
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Louis Taylor <louis@kragniz.eu>, Jonathan Corbet <corbet@lwn.net>,
        pmladek@suse.com, geert+renesas@glider.be,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 12:10 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Mar 03, 2019 at 12:36:47PM +0000, Louis Taylor wrote:
> > A few commonly used integer types were absent from this table, so add
> > them.
>
> I'm not against the patch, but isn't obvious by reading POSIX and / or man
> printf(3)?

You'd think; but based on the sheer number of -Wformat warnings
(~450), I'm not so sure.  At least with this patch they're "above the
fold."

The kernel also has its own format flag extensions, and does not
implement %n (for good reason), so it's better to be explicit than
imply posix or glibc compat.
-- 
Thanks,
~Nick Desaulniers
