Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF3C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354A4206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574266202;
	bh=GOfJLazKNOGUF+DblV0QgkbUDg+AIwFteXE9cjv0msM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=frbnfM1x+k/tHCsg8LfTJaIwIrkJtQLM69RxiYOFXbtyXQk6dcE3gnC3rURJ+5pFu
	 CUuMRKGyuQfTKM4c89uACZg09JD8QmwEWx29QDpd+uJoHK+9/LprpPmF8qFoTgDzyl
	 S9fGogBg4iTecg7BS1gcXFEfsQvhaqeGrxkhgjIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfKTQKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728017AbfKTQKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:10:01 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C18D2071B;
        Wed, 20 Nov 2019 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574266200;
        bh=GOfJLazKNOGUF+DblV0QgkbUDg+AIwFteXE9cjv0msM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fEpvkFLc5PDAykz78tNIYyiCQH0w8l3fNWyP1lGOzZPRATcYb1fM4QaT2pyINmkDv
         q/kOuhvDKXlRTXR4IlsRdcyquuhi7xY4FRLZCM7hhAxUISxoTYbs3DCMA8iLtd8Mp5
         d4RwoNOQXZfVVGqZ0r4fSJ0hfiGrK+tJmjEjLfv4=
Received: by mail-qt1-f171.google.com with SMTP id j5so64551qtn.10;
        Wed, 20 Nov 2019 08:10:00 -0800 (PST)
X-Gm-Message-State: APjAAAV8JHXg3eGirZRurMrVJ5VDq8uZVVfPzPSXSrbu56Rc8KpyQurb
        KToMPKW8MYpjyFs0NGAcINcBm5ydnwxqHf19Kg==
X-Google-Smtp-Source: APXvYqw3p2yQb6xBvbD23JDCGsCZyWm+FuELn8bHCVj23z04Oy6XY0ZjLoc2HtFsISuVdqYEfqWjo3pI1Xk8fiVtv+I=
X-Received: by 2002:ac8:458c:: with SMTP id l12mr3469968qtn.300.1574266199801;
 Wed, 20 Nov 2019 08:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20191120040045.81115-1-saravanak@google.com>
In-Reply-To: <20191120040045.81115-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Nov 2019 10:09:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4JQ7Oop5oWUYRCNA-xQrd0svQSPrp+y1F+Qux9xTRrQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4JQ7Oop5oWUYRCNA-xQrd0svQSPrp+y1F+Qux9xTRrQ@mail.gmail.com>
Subject: Re: [PATCH] of: Reduce log level of of_phandle_iterator_next()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 10:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> These error messages are mostly useful for debugging malformed device
> tree data.

A malformed DT is an error, no?

> So change these messages from error to debug messages to
> avoid spamming the end user. Any error messages that might actually be
> useful to the user is probably going to come from the caller of these
> APIs. So leave it to them to decide if they need to print any error
> messages.

Generally that pattern results in every caller doing their own message
which is the wrong way around IMO. And recent patches fix some of
those cases[1].

Rob

[1] https://lkml.org/lkml/2019/7/30/41
