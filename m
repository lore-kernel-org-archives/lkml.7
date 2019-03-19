Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91320872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfCSDj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:39:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36938 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfCSDj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:39:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id m12so15340752edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5kqMjiigc5qV6mOW5EcbcvgtHIo5LcTDDEzWRih5HI=;
        b=dt0xTRVghLg8xqD7KrdyCEL6Rh72ZkH4iEWbM8aF+6QCJ1ThAnlvx61+nqT6J9Aj2L
         4kBHlFlD3sBUnn8XLOBZgLVBqB2VuWX4S1xREy+7vH6I7gj20XytY/QEKaJu6x+1H9Ii
         0+6e836IPsJi6STkeDhPfXVAASNU7zsJFFvLvtz9m1+eCclNtkfqQFGQbyWFlDdK6d78
         QGzJEXyrI5QmQxqjym0vhDj97B/UpxTCsDt2Bef+w4JM+bOo7iFMfCqICeazfpnRIqL9
         oU1XQCiV2EuXIUM9Ic3APxK3bwDXTA2mu55zbxnbKKHNDWag1lvTfqsIImnZ5Ey+64NP
         +42w==
X-Gm-Message-State: APjAAAXq3SytjoPEqs4wE80XQbIoo7O0ffKPFaOEQVVOWRj0bvq/eBo6
        eEIvxn+B0X8hKbd4RjnVpa+zggWkeEk=
X-Google-Smtp-Source: APXvYqwtcvOZ+Ycruo6luOHRCf9Yg4co/S/w92ugT4/Yo3p6TvoRc/FdtXzcTyNSlDjhx5BSgvNwMA==
X-Received: by 2002:a50:a4ec:: with SMTP id x41mr14939604edb.27.1552966764771;
        Mon, 18 Mar 2019 20:39:24 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id q11sm2757696ejb.39.2019.03.18.20.39.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:39:24 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id j9so5178811wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:39:24 -0700 (PDT)
X-Received: by 2002:a05:6000:1107:: with SMTP id z7mr14005276wrw.87.1552966764132;
 Mon, 18 Mar 2019 20:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190319033608.6363-1-axel.lin@ingics.com> <20190319033608.6363-2-axel.lin@ingics.com>
In-Reply-To: <20190319033608.6363-2-axel.lin@ingics.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 11:39:13 +0800
X-Gmail-Original-Message-ID: <CAGb2v64b7kz1prkzPBk1YHmsVLhH0VqoUjsAhvWib=GY5=Dgtg@mail.gmail.com>
Message-ID: <CAGb2v64b7kz1prkzPBk1YHmsVLhH0VqoUjsAhvWib=GY5=Dgtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: axp20x: Use rdev_get_id at appropriate places
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:36 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> Use rdev_get_id() to simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
