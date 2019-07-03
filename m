Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEBFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952021882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:33:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37152 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:33:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id s20so3219853otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sN8SjiSoTlwKd+MHKIy7hmdapLfkm12Ci8ci1qQb/50=;
        b=bNDjHuEUrugTgzP0gvqzL7DSmiwSwez/CNzT1FzKFUxKi4nTxD3gTz0vy6dknFrckC
         y5oh5peNE5yE0ltUCZG0jAFllK1SDknGIuLokLLZrZl2GLigvljH219O4eW8fMJa72jQ
         Y4yiNiN4Udi9d985b7SvKt69R3u0Nodl1Ms5UWUiPNUFEI+g+gCBAyHxiH7N9foozLKv
         G2iwlZH7uM44IxttuklhaTNjFNN2dOdnovkOMFzcMGEwadYsCnTSPVyOe7S143S6j66n
         x2vdQ7V2MoXQS5HbMwiLZXtSns7mxDIc8OKyeZuh6ID4ANneQwxRilZ4qjokxpINt++q
         mhuw==
X-Gm-Message-State: APjAAAVQXNvFs+2aPPWiybMNZRhPA62vpJBO1T8jCM9Bcd9NP+UU9BRM
        ocixi9bdNH41YH9bcCWXiCs=
X-Google-Smtp-Source: APXvYqxaAv4XfhTXyzOQEO5Mh5YfM0MiSUILT0WL4cl68IyGEe7Admy91MEMDtoIkz91MLOpjRO6+g==
X-Received: by 2002:a9d:7248:: with SMTP id a8mr31564520otk.363.1562175216928;
        Wed, 03 Jul 2019 10:33:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 132sm924488oid.47.2019.07.03.10.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 10:33:36 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix use-after-free bug when ports are removed
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703170136.21515-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
Date:   Wed, 3 Jul 2019 10:33:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703170136.21515-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey,

Hey Logan,

> NVME target ports can be removed while there are still active
> controllers. Largely this is fine, except some admin commands
> can access the req->port (for example, id-ctrl uses the port's
> inline date size as part of it's response). This was found
> while testing with KASAN.
> 
> Two patches follow which disconnect active controllers when the
> ports are removed for loop and rdma. I'm not sure if fc has the
> same issue and have no way to test this.
> 
> Alternatively, we could add reference counting to the struct port,
> but I think this is a more involved change and could be done later
> after we fix the bug quickly.

I don't think that when removing a port the expectation is that
all associated controllers remain intact (although they can, which
was why we did not remove them), so I think its fine to change that
if it causes issues.

Can we handle this in the core instead (also so we'd be consistent
across transports)?

How about this untested patch instead?
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0587707b1a25..12b58e568810 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -277,6 +277,21 @@ void nvmet_unregister_transport(const struct 
nvmet_fabrics_ops *ops)
  }
  EXPORT_SYMBOL_GPL(nvmet_unregister_transport);

+void nvmet_port_del_ctrls(struct nvmet_port *port)
+{
+       struct nvmet_subsys_link *l;
+       struct nvmet_ctrl *ctrl;
+
+       list_for_each_entry(l, &port->subsystems, entry) {
+               mutex_lock(&l->subsys->lock);
+               list_for_each_entry(ctrl, &l->subsys->ctrls, subsys_entry) {
+                       if (ctrl->port == port)
+                               ctrl->ops->delete_ctrl(ctrl);
+               }
+               mutex_unlock(&l->subsys->lock);
+       }
+}
+
  int nvmet_enable_port(struct nvmet_port *port)
  {
         const struct nvmet_fabrics_ops *ops;
@@ -321,6 +336,8 @@ void nvmet_disable_port(struct nvmet_port *port)

         lockdep_assert_held(&nvmet_config_sem);

+       nvmet_port_del_ctrls(port);
+
         port->enabled = false;
         port->tr_ops = NULL;
--
