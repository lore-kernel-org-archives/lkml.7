Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE4820851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qbe1O5en"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGWqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:46:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55641 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCGWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:46:01 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so18010240itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dL0oQyirigKR6oGf/iM33KH9tMR7ax1RdceqBX6W0Yg=;
        b=Qbe1O5enm9f/oX6W1DZHIwBZdod3K9wsXX+c9xwlQnG2F3GclO/tCVXnMewtK5QklN
         nHPOxXP8ArIPX3IYLVJnS/vRoq8K/OrAu0+L9MDuUnUzSZRjm1mgiNlwSarsDXdv93ph
         gFn1Zw8KT3KlMX1g5ZGrmGX54ojLqR21whoRBpxmuqMlz2vpxcfPK3Wv7AV4NGk1FBn6
         BvW5LU02/HCkNoWWfwc/EvU6DidDh0Q2cqxR6vPU747rHIqhx9ZNAo5GBwYuwfIi65MO
         c9CQi+IlBteHDNoVWoBNhxHn2N8PGlL6hPWwfvWvPWZU2t1qun3AgV6fOOCrBdA3DCxt
         HBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dL0oQyirigKR6oGf/iM33KH9tMR7ax1RdceqBX6W0Yg=;
        b=TQiJxJQtqQ2hR27lzZM7YZOjKkAjnylgT1+tj5//c7y7y3Sn7UWCauj57Pif9BUhMW
         ZB5uoo50ulUMVF+ALDwJmmnucQ6ac8vs4JnU8oGa38lH0a/IYqf/UpuH5+b0Ms0y9hZR
         K60N7/trEtWr0tQQGcxwxmZKiYIAG/UbuNL5FSnoK03XK5LO6LGMhHYZdrAqEhifo063
         sj6OU2f2+XaZ/058/wCIsVKdehoToLnnMORgPEBZNMk49QHW78AXBb4KysYDor4J5eqH
         FRMj0mjjtXmtN+vv5pJhf1QTvpBdT64w5XW23463sYBNmCsXruZCIsyPzaPZEHcjWafl
         T7lw==
X-Gm-Message-State: APjAAAXEkPtQQDzQBBIWzG6GaWa7KxOMmrEtTrKugichZhZgIPO70wtv
        zvzhaw+UorWzJ35Ah634kTd9RHizG/s5GUZeohx4kQ==
X-Google-Smtp-Source: APXvYqxgN7XVqND7zXpxh+e0Qs78ZxOZPW3yCcFqpHjlCi9Uca7fRlMpXAf4P7CxfVWxavKWceNnbKnBG6M6yEta2cs=
X-Received: by 2002:a24:7908:: with SMTP id z8mr7185538itc.16.1551998760501;
 Thu, 07 Mar 2019 14:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
 <CACdnJuuPyL3Qo4jAiJDQvUF9Ctch6Yo2bKezEuQ2KaM5ZZ1vqw@mail.gmail.com>
 <1551998075.31706.455.camel@linux.ibm.com> <CACdnJuus7zZWDfJHu+nckn+t-FkRerh7vzX2eh=1nGsbX=kbgw@mail.gmail.com>
 <1551998498.31706.458.camel@linux.ibm.com>
In-Reply-To: <1551998498.31706.458.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:45:49 -0800
Message-ID: <CACdnJutjkkk0M7r-2Cm1oBGxRS7CjZXmjn7CYQ+E-cg4HPkzQA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:41 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2019-03-07 at 14:36 -0800, Matthew Garrett wrote:
> > Right, but how is this different to what Linus was objecting to?
>
> Both Andy Lutomirski and Linus objected to limiting the "lockdown"
> patch set to secure boot enabled systems.

No, Linus objected to it being automatically enabled when secure boot
was enabled. It was always possible to enable it at boot on any
platform.
