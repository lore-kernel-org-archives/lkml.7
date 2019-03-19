Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1227AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49F620857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owDF4J6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfCSNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:14:33 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41686 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCSNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:14:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id 10so14354824lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJnUg3t0gpVkdGnmj65+sIb4IWTKMjpA284qzii54dM=;
        b=owDF4J6tGosEQnU3L9gQq2qUtf/Y4iY883gCcwAjXlTO0e96k0ZSnidbjHiSeXQ5JA
         LSyWNLLJhP95BqNspTU20x0aus40veUT1jT+e0re+eJOAEjiqPdk9l4WkoYW8CkcS4z5
         qxm2XTnPofKeDyTQQaYa/l8DvzfYG6rWXpvU4Z05Bj9gxeaAyeq8Ur23+FDdd8nMwOnp
         PY0BwHFh747Hbtc1WWNDrzmCkfRRX2usbN0A/s7T/e591wA9+J8vF80pcWCAYJyCvd2J
         O/xO9r3kAwt/ZM8UEgAcEvq3+ViwJ8Ynch7NGnQAf3QmrcViEOHIaPWVokOCwlb0O0zy
         0nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJnUg3t0gpVkdGnmj65+sIb4IWTKMjpA284qzii54dM=;
        b=SnyDyOS3jXji6fImb9Qoy431SuQZh/ic3aN7aOXrTj0uVLE/WH2K8qlFDkjtkiQzZQ
         C4NDzNVLFsg6Z1eD/IoReM1XrN9X9ifNgdAFqqi7QdjIJSAzudYa6Q9X3IeZC05IJit6
         lYsccwZt20ccgHp436DFi2nYojmM8t0vBvK5Dl5cEq+PuqbjIdqARPqetGQwrG9Iwpzh
         +5grSh/jlOmsVSOm/2hpTRV9vYURVjBMqy09Ghh9APeRMxED5ATkq9iLu1pPfj20s9Ul
         4nObCcoO0rhLnXQ9jRcdbTj952JwKVVpxvA+btPZdcnxOqi+8XqDbmDdxPT/Jg/GnEki
         qHaw==
X-Gm-Message-State: APjAAAWEDyJMlt3NEhQK+vGIQHpJEgDUp9J0e6xLblZdQWgtfei+xsxj
        85SdrA9GdkNGDISEv/KLaerWa/cQniDEkJ7lLMI=
X-Google-Smtp-Source: APXvYqwllbDVNlNHpFnPalZK0pqFFiMZc0+qQeUKejCNvDil+NggK5nDW0Ki4ht0hp/KvKnV19DBgD/3Rx5vqawv3lo=
X-Received: by 2002:a19:f208:: with SMTP id q8mr10291431lfh.107.1553001270698;
 Tue, 19 Mar 2019 06:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190211131602.3294-1-peng.fan@nxp.com> <20190212172700.xwtomhb3qahyxugx@shell.armlinux.org.uk>
 <AM0PR04MB4481452226EC21AA7B90735288400@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481452226EC21AA7B90735288400@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 19 Mar 2019 10:14:19 -0300
Message-ID: <CAOMZO5BNZaQu8xXvVuxdFbCKPFypajq7qimf6Mk-KAYx-EHcHA@mail.gmail.com>
Subject: Re: [PATCH] arm: use memblocks_present
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Mar 19, 2019 at 9:31 AM Peng Fan <peng.fan@nxp.com> wrote:

> > Looks good, please put it in the patch system, thanks.  Details in my
> > signature.
>
> Would you apply this patch? I do not find this patch in your tree.

Have you put it in Russell's patch system
(https://www.armlinux.org.uk/developer/patches/) ?
