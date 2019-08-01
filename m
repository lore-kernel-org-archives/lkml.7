Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4AC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9nP+P/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfHAUoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:44:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36540 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfHAUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:44:22 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so43775396iom.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kEYB2+OVQo5XUoP0DBjTnNKzZvTb5NJlv5p6H9Nyzv4=;
        b=p9nP+P/1loHtaBCdy0RixW63mz45R3rvCZ00Zldzay+dbiKdcAlP60JiUO+vB9DPGE
         NQJ1C+W5QRgA7GRQUTDum4dZCx4LwgnvuxVsXej6GZylA+kvpVZq6l0dgut7812mYn35
         DsWqOMKrGeUGD4tPXmYcmWJx8fuBLkIxm3KMTmysQD92yPn1C5Vm+b1mi3yzYNgbfw2/
         Y8DRxS8fqk8/SDEMiHv8A4b1GCoQG4Xo4d3w8Q7d89vyRaK4T2aOw/ElbTU7zkWGpfdv
         PY4K3r3n6JTqdYh5mfC26n9HDI5B+8uPadncMj+1BwM8CqiGALvnDTb7ncp/F7ZNkpCx
         tO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEYB2+OVQo5XUoP0DBjTnNKzZvTb5NJlv5p6H9Nyzv4=;
        b=UzTjR0x7LJkG1vlgzQ0a8lH8kEANaod5gcqxatRFdugaQfKKXlI1sP0zqegso4bhQG
         /J7O1VXZBTKsT2YS2bP6F2oGulOVGi1KT2C2QFqfx8kQ/iDCFVQvOscXtwI76a4e43lc
         vDt0dTM31rg0Oi99S77WB4XuhFyySECaMNLqiV85bHUzVctk2h5mk9W/AZA/4ZXpQVw9
         tI3Zb0gQ7xaZ6y+TVHN+Iyy+F0Ziau/zLUhOcvxc7wKnmwCAy1mo+VjrlKvT+OuMSm0l
         C3A+liQmisz6xlsey6Iv4UtSK25OuSiokQdWomS1tItIKmVFcVmaxKQ5D4Ofk+cOoUEE
         TPCA==
X-Gm-Message-State: APjAAAVCdSDTRvChIYr2puM85vXEAHRjX7sZ1ZsGUpPTYJJ50uHdxHK/
        6AKDYTR0v7eNDb0OMW1qR3qL0c5ooh4ZRa5GFTH46A==
X-Google-Smtp-Source: APXvYqwMBy0UyzznhL2qb2ZDkC6aceenmGV8TFVCHyy3LZ6BRmQiV8H2e9lPWkZWc9KUJul91Wj9CSU+s9ZSbxWcPHM=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr5004672ios.84.1564692261567;
 Thu, 01 Aug 2019 13:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-20-matthewgarrett@google.com> <20190801161933.GB5834@linux-8ccs>
In-Reply-To: <20190801161933.GB5834@linux-8ccs>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 1 Aug 2019 13:44:10 -0700
Message-ID: <CACdnJutXUO9e0ti8tHtJ8z3xX6dcn4Cczbs-wMBRr07BM3iCvQ@mail.gmail.com>
Subject: Re: [PATCH V37 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Jessica Yu <jeyu@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 9:19 AM Jessica Yu <jeyu@kernel.org> wrote:

> Hm, I don't think the doing parameter ended up being used in this function?

Thanks for catching that, I'll fix.
