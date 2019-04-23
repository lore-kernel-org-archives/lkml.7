Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F0FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7920652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556007826;
	bh=2libRlfojD3D5tadb4aROSDq4h9dH3uTALfwH0ONYLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Wv0cQS5UtW4lOIhuCRmAft9KkXwMAUpBiEPVrklhxa8hkelAB6g282rch64v/LXb
	 huP7kFZLs7tqxIBEsEMa6MtMWy1H3RsMVU+/aDHCtXOTN60q1y5ExnS9JmDCyQiZaG
	 HRm0Bt165Ne1owHyP4U7s2rb1KGmjWzdeAxwN1H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfDWIXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:23:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36445 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:23:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id l203so10602935oia.3;
        Tue, 23 Apr 2019 01:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2libRlfojD3D5tadb4aROSDq4h9dH3uTALfwH0ONYLA=;
        b=k/ZQotonKW1klVpCqMKk/XO0MnAAOw/yBZq4rwOEzEsIA9QR80gbhxpGCQrmTtgP9d
         E5btjpYiWIP+1CrdhNGOhuOiHLg9M2u5BYN4xUJgXcjAUYcsdUdRTuC5YWsbnOr23Be4
         KXJoBIdCMVj9c+ELBJFMTPqTnArz/iNG07bE943DGTQWPgy/aGHjLJYAlLq2nyyQfHA9
         GjUrkAyMhWFHij3FIiOmYJuTrEo9bYWUJSCxtEac6XS44eYlwNVctWCmzjsMmuZq1SAr
         S9JlZQBJj7l54PVtVe3wgpwm7WVM6OGifi2qQ8Okvx/E1m8ziXSroU7/nIEsoBZ8zasO
         t3iA==
X-Gm-Message-State: APjAAAXXXwCp0k3JZMbjamispJKFWqXdpvzcwixiFUK2m9HGvEZTXL1W
        y/OOvbfDqP760gSZ1gyc5ajrneqwIVExdyIBVYE=
X-Google-Smtp-Source: APXvYqzoJ5kqEsfLmSoMDS2yawMhS20KyL+7R7WSfVfsY7vOO/NfdWQ0gJ9V8S65dYU1C2AmQn78Km9/Rb/DQshkNj4=
X-Received: by 2002:aca:6c47:: with SMTP id h68mr1051957oic.57.1556007823908;
 Tue, 23 Apr 2019 01:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190408161240.GA30623@embeddedor> <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
 <1c208944-9162-0245-c3bd-016f4274511f@embeddedor.com>
In-Reply-To: <1c208944-9162-0245-c3bd-016f4274511f@embeddedor.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Apr 2019 10:23:30 +0200
Message-ID: <CAJZ5v0jUfLpp_q7ozi33wgJfP7zHmvDh2Srun0KjVZj6Q7NOfw@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: fix file descriptor leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 5:55 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping:
>
> Who can take this?

I've been waiting for Len to comment on this, let me talk to him offlist.

Thanks!
