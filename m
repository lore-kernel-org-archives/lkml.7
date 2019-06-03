Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95125254
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWohiKBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfFCWH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:07:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36434 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfFCWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:07:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so11389069pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsqt76+/tC7lNIGkBOfSxOR0w7kTsY9VRuEizjLylaM=;
        b=lWohiKBqCPBenj/eJUzVHOJpCdAi91g5TtT2pyrV0FfesO2LcED3e8srNOon8Iibg8
         XtIVB4yvu8opanO7FhZdkXkw4qrcWHepKTZehjxMhdJDV96SRObFjXSOJ7rGU53BIOCP
         amFtVM8IVZTgsTynPUL6wWPlqXYRwRZZzxCbIY9Ee0e3Vl33p4qUyAVxj8FpxZ60liZ+
         tlqBRl6mtiIkFKWFCab1uDZBalnO4+vn2OxS13m7xXU6v0FU5TV28RkCj9ovOInxVDww
         AAHmWcMNk0lFA89DRsCsZY4WJwkQ6CMV6qh3KnKzsG3YvEUYZUc8GLtbMBr5SeewywTj
         cL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsqt76+/tC7lNIGkBOfSxOR0w7kTsY9VRuEizjLylaM=;
        b=YHpf2yXBvY2JksGVu3nbOm6GQrpdPGLOuUueWFofy85vSusR7wsvYh8u/putOnxakU
         EChJAYWminft4osUOcDWoImGeb3Zg6kTTeqPxKnxrXHFEH7AKHFr5Po2/UIahSbXVlPo
         9HSV2ssoaiBExGAUCJAeWBNSu+8JVKHNnQmGMlTrL4fU/OBDXH5ejeWanWvbmds9xbSP
         d3KSz2/DcAg4jUtMBqpMK8OXWltEJeK38h2v0tsElfngI/vnMeLi7fOnMDIuU7/Qt4l4
         0/fj/b4JyzQHSfLN6s1W6M/ZmQDflPTmaztkAI4vZK2gl1NRcjFRgOfKjVcsKdstrMTS
         Es5Q==
X-Gm-Message-State: APjAAAUGgK39spSddVRo1Ijh9bYe/ZGex4eCgPHBSuh2hnR/WdH7AwTF
        YhJ+Rocu+YJAh4h7AsDeBmXF1Za2/eXajjIoBpDiMw==
X-Google-Smtp-Source: APXvYqwtRDahz95jt5ckTsuH+i7KTn9MRTd6CF+6hpsuPoa7lkdPVCsC5gUhiu+y1T7oPa6/2fCZnPaB/OkOvv8EDa4=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr5763850pjs.73.1559596083400;
 Mon, 03 Jun 2019 14:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190603174323.48251-1-natechancellor@gmail.com>
In-Reply-To: <20190603174323.48251-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Jun 2019 14:07:50 -0700
Message-ID: <CAKwvOdkQzdZezwf51UddFVGQh0mRFMEexr1cMHx=va88T515YQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rpaphp: Avoid a sometimes-uninitialized warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 10:44 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Looking at the loop in a vacuum as clang would, fndit could be
> uninitialized if entries was ever zero or the if statement was
> always true within the loop. Regardless of whether or not this
> warning is a problem in practice, "found" variables should always
> be initialized to false so that there is no possibility of
> undefined behavior.

Thanks for the patch Nathan.  fndit isn't really being used for
anything other than a print statement outside of the loop.  How about:

```
diff --git a/drivers/pci/hotplug/rpaphp_core.c
b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d357ca23..c3899ee1db99 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -230,7 +230,7 @@ static int rpaphp_check_drc_props_v2(struct
device_node *dn, char *drc_name,
  struct of_drc_info drc;
  const __be32 *value;
  char cell_drc_name[MAX_DRC_NAME_LEN];
- int j, fndit;
+ int j;

  info = of_find_property(dn->parent, "ibm,drc-info", NULL);
  if (info == NULL)
@@ -245,17 +245,13 @@ static int rpaphp_check_drc_props_v2(struct
device_node *dn, char *drc_name,

  /* Should now know end of current entry */

- if (my_index > drc.last_drc_index)
- continue;
-
- fndit = 1;
- break;
+ /* Found it */
+ if (my_index <= drc.last_drc_index) {
+ sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
+ my_index);
+ break;
+ }
  }
- /* Found it */
-
- if (fndit)
- sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
- my_index);

  if (((drc_name == NULL) ||
       (drc_name && !strcmp(drc_name, cell_drc_name))) &&
```
(not sure my tabs were pasted properly in the above...)

-- 
Thanks,
~Nick Desaulniers
