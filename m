Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA0C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE362081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bN9ihfMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAFQP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:15:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36368 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgAFQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:15:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so50270672wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IPjzpRoYE+JzMIzBRc/67gO42QGNlC0QHXvvKHZ+em0=;
        b=bN9ihfMlw7yCWRT6zDUMNIBSfZKgrC88Dg5/DHzN1Sj3ORWfM8jjAsZ2aATSKuD4pZ
         UVZxVvT7RGB7VV+3H62l4PA6UBkOkx5ez6c1CnVrzWX/xECO1ZjE1zZl/uS+JM8P+SNp
         oKsHHzK7khrSgy+dTK3UWQc3uix95QD5fvKlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IPjzpRoYE+JzMIzBRc/67gO42QGNlC0QHXvvKHZ+em0=;
        b=Q7LaZucde60Dg4AlVotuxIulnz1HxiArwv7uH+wl44dU9ThLIQ3XDW8TdM1VrTcW6p
         8EWro5tq3p3j1X+4nHNIlTPl19Ad0KOt4aoSDGyyMxcN46PV1FPDsTeySt5gmbpvpqiS
         DTmrO3fHef76u4E2jtW29gE1ML7tCeEAMzDGNqQvU0t0Sut5+9PvM9OVxMZJDeiuhy06
         yvolqBRFDQciVsIiU4T94F0SAA68oZKAYD1Cc5ZCImbEEHX/kVJ3HI0Lxl1xejqfDoKg
         oOdxQiXOXDKKt6jNmTsd/iuU2Vwc8seWmGLjI2GIkEXCKbmU4AuUsMT6mYmh9mb8JIi/
         kiAA==
X-Gm-Message-State: APjAAAXdZMYxpkNcJPccL/+Op3pu4FD+zPDk3BB3F5cSmzHBsgg9Dr1p
        WGDIA6NQ80/XxQpRzt1EdOj/Og==
X-Google-Smtp-Source: APXvYqyKRUfAeaI/31baOUelcLazCeXcEGozHYa38/CdOUyrNHEwsBlNK08JcgvK+K0J3RJ0N+m7Xg==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr25503891wrm.24.1578327324773;
        Mon, 06 Jan 2020 08:15:24 -0800 (PST)
Received: from ?IPv6:2a00:79e0:42:204:51d1:d96e:f72e:c8c0? ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id x18sm73045384wrr.75.2020.01.06.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:15:24 -0800 (PST)
Message-ID: <a1d896052f608c549b67997eddd62015d2d230d5.camel@chromium.org>
Subject: Re: [PATCH] ima: add the ability to query ima for the hash of a
 given file.
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Mon, 06 Jan 2020 17:15:23 +0100
In-Reply-To: <1577122751.5241.144.camel@linux.ibm.com>
References: <20191220163136.25010-1-revest@chromium.org>
         <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
         <1577122751.5241.144.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-23 at 12:39 -0500, Mimi Zohar wrote:
> On Fri, 2019-12-20 at 08:48 -0800, Lakshmi Ramasubramanian wrote:
> > On 12/20/2019 8:31 AM, Florent Revest wrote:
> > 
> > >   
> > > +/**
> > > + * ima_file_hash - return the stored measurement if a file has
> > > been hashed.
> > > + * @file: pointer to the file
> > > + * @buf: buffer in which to store the hash
> > > + * @buf_size: length of the buffer
> > > + *
> > > + * On success, output the hash into buf and return the hash
> > > algorithm (as
> > > + * defined in the enum hash_algo).
> > > + * If the hash is larger than buf, then only size bytes will be
> > > copied. It
> > > + * generally just makes sense to pass a buffer capable of
> > > holding the largest
> > > + * possible hash: IMA_MAX_DIGEST_SIZE
> > 
> > If the given buffer is smaller than the hash length, wouldn't it
> > be 
> > better to return the required size and a status indicating the
> > buffer is 
> > not enough. The caller can then call back with the required buffer.
> > 
> > If the hash is truncated the caller may not know if the hash is
> > partial 
> > or not.
> 
> Based on the hash algorithm, the caller would know if the buffer
> provided was too small and was truncated.
> 
> > > + *
> > > + * If IMA is disabled or if no measurement is available, return
> > > -EOPNOTSUPP.
> > > + * If the parameters are incorrect, return -EINVAL.
> > > + */
> > > +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > > +{
> > > +	struct inode *inode;
> > > +	struct integrity_iint_cache *iint;
> > > +	size_t copied_size;
> > > +
> > > +	if (!file || !buf)
> > > +		return -EINVAL;
> > > +
> 
> Other kernel functions provide a means of determining the needed
> buffer size by passing a NULL field.  Instead of failing here, if buf
> is NULL, how about returning the hash algorithm?

I wasn't aware of that. This is nice to have indeed! I'll send a v2.
Thanks!

