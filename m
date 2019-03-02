Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9A3C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7AD20830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AdIzuwUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfCBBfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:35:32 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44574 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCBBfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:35:32 -0500
Received: by mail-oi1-f179.google.com with SMTP id a81so21054209oii.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 17:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgxHDvPufqFDBpKOE6xNjJSVLfO3JpoWrIb1UK/QmM8=;
        b=AdIzuwUUH3BiXvyFJDFQcjjwdivf5GalHVKuwaCFMroTnNhCcMxbYOKpddGW4TUh8+
         Y6gtBYvLhMfQw9tZ1oAe7jAJJxc3EIMYbhWQK0NJy+PET+6OwCLrPsHeLbc0oDh0djHr
         T72V4lBjhqQU+9fHhAaLv0gffGuv8NlCFQk1XHc6fB38+eKLmOpjMhQCvC+mRScd5zRy
         LD2xU5h43726yunZt8xkghbO8DLIOGbo0Dj2ECati322KNkD7mtIqeKvDBzu+3hEDwCJ
         AMMCXoHZB8DF7stMmNo9L3Fit/8umB5lUBJpjUv8LNAFBqREyiYLXbqsG8M0qTI8SDsL
         Kd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgxHDvPufqFDBpKOE6xNjJSVLfO3JpoWrIb1UK/QmM8=;
        b=RM62VM4GzOIhSbZMJNqMvzDVP4OUyMw7tlrXhMxKV152hMGc2288PyK/kKF2bG9jjd
         aq6FD0XwuBFL2v/UNQXKYstbme3unopW1gjVOeMsCSfJ8cUZStat9VXezUT9eykKK6Xn
         vAXFXlzFGpd+hkEnnFuOTt0TWvJ2c2eoWrajExxAPWPRMGh1VyOqyV0HqnHr2JLi3TRU
         SNHVo7TDNs73ojtritYQb2z7I5ARCDznP302+XBnSAqM5w+5ZUt4/4b3XOciUG21NmzQ
         pCOdF12fEYZPAWQkLdWJdSd2GsE3l4t/Fmpw0LymLfoWWubTpPBYSgu3bJSrvY6oWkW5
         Q+7g==
X-Gm-Message-State: APjAAAXEfPQod74jXnbQuJEhbG6RAjj3z+iQjgfWTEz0iRdzDHEYzFNJ
        93woSwifMz2qKBWi54SeG3kRJ7J9wq+ssidrCm8j/A==
X-Google-Smtp-Source: AHgI3Ial77ksJmnKCkvv5RpjYFG0q9A8l7bRTQfp/SRgionusjRYFc6Jbz70watitZsE1SgSTnbXf/Jkl9JO9Icm5x4=
X-Received: by 2002:aca:3906:: with SMTP id g6mr5320619oia.149.1551490531280;
 Fri, 01 Mar 2019 17:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20190228201218.12501-1-toshi.kani@hpe.com>
In-Reply-To: <20190228201218.12501-1-toshi.kani@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 1 Mar 2019 17:35:19 -0800
Message-ID: <CAPcyv4g0rderGJ+tQvfzNvhrndLWJSsTYPiM=FjL+eoKcHDKkA@mail.gmail.com>
Subject: Re: [PATCH] update NFIT flags error message
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:14 PM Toshi Kani <toshi.kani@hpe.com> wrote:
>
> ACPI NFIT flags field reports major errors on NVDIMM, which need
> user's attention.
>
> Update the current log to a proper error message with dev_err().
> The current message string is kept for grep-compatibility.
>

Looks good, applied.
