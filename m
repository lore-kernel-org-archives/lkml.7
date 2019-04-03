Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F55C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E920830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfuQdVW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDCMIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:08:17 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35508 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCMIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:08:17 -0400
Received: by mail-wr1-f48.google.com with SMTP id w1so21025595wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=GguOis0TNjEhCnveF9SJU+/OKkeHIxndz0Sf1FaMQ5o=;
        b=cfuQdVW94oYWdXo6ayWx7w7K9MVFwINBTtTxHiu2pbVYcyZha5Aw+DdFaS4Cr8XQkv
         71p/D5Ym/boo+1zNIxYnQYaIM2lDo5CeHd1PS7zRhTPF65Td3WL0Z3QF0UnIFOlSbO0t
         ZOr+/p1eLZQ63fduf6K8snmQU92ICZpX+5AwvV0yWKxD8h+BNjOl/ZqmDCXdVYlUbs4x
         7junRXMJiM70G2PIfjNRgEGqVJv7SEN8IjxGwTJ6p6Se07DSBc/KB9c44GcCDrahNzMy
         5EsJshrgvSihHeuA1e3onQG7DbIpJeBTZ+EDQd4Ni2dXrg9T7tSl5gnrTrFUaeX2fYIj
         0p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=GguOis0TNjEhCnveF9SJU+/OKkeHIxndz0Sf1FaMQ5o=;
        b=mpFllcposgHhmGMEZ+6kWau+vs4N6yxelzo/rWCQNr74bewUwjxf5criWejYNLgYQg
         vOgZPt+4dyKNBXNKeB+oyBW9ItxQmdt8/PL9bWVYLfTLvkjtAUVUAWBujFk8WSumB/EW
         ACwklkLeu0ipliIFbKuH1TPg8auu35eVX6oK79gkHl2pN6acqyDYyGcSstF8LMbfFsmy
         BxfkWmJDX7JvrEteZmHYYlW5kZ6+pkK0YYheLZ2Odbe59HDhFsR7VbR1FB0vVe/RvrLv
         TbJKopbCIY/JkBCT1vkyXB+UTV45Wiz5O85sfuedVEcWA5YwHstZr9abiuPUaeMh0nrk
         PAwQ==
X-Gm-Message-State: APjAAAXE5PWn4gCy7Em72x4K1AeWnywAqF+TUnlqV8KW15vxvu42tldw
        TO4Wg9/jUxnZZo/oYnAAArGYDaWo
X-Google-Smtp-Source: APXvYqxvh8SIWsnDtfmU/rMwn1LEtlqBolldMlo+yENKdyGizTVbn8uySaZNU7hgAPHmQVvZKVpxhQ==
X-Received: by 2002:adf:f7cc:: with SMTP id a12mr3172521wrq.87.1554293294037;
        Wed, 03 Apr 2019 05:08:14 -0700 (PDT)
Received: from [192.168.107.155] (x4d0b13a0.dyn.telefonica.de. [77.11.19.160])
        by smtp.gmail.com with ESMTPSA id g19sm16116369wmh.17.2019.04.03.05.08.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 05:08:13 -0700 (PDT)
From:   Oliver Henning <oliver.henning@gmail.com>
Subject: Unchecked kmalloc() calls
To:     linux-kernel@vger.kernel.org
Message-ID: <9f3ba19b-70cb-7631-9426-7aabacc1fdb6@gmail.com>
Date:   Wed, 3 Apr 2019 14:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have written a Python script to scan the kernel for unchecked kmalloc() calls. It found the following instances. I checked them manually, too. I would like to fix them myself but I do not how to do a proper failure handling. So maybe someone else can have a look.

Oliver


drivers/net/wireless/rsi/rsi_91x_mac80211.c:199
             channels = kmalloc(sizeof(rsi_2ghz_channels), GFP_KERNEL);
             memcpy(channels,
                    rsi_2ghz_channels,
                    sizeof(rsi_2ghz_channels));
---
drivers/net/wireless/rsi/rsi_91x_mac80211.c:208
             channels = kmalloc(sizeof(rsi_5ghz_channels), GFP_KERNEL);
             memcpy(channels,
                    rsi_5ghz_channels,
                    sizeof(rsi_5ghz_channels));
---
arch/mips/pmcs-msp71xx/msp_prom.c:378
          argv = kmalloc(len, GFP_KERNEL);
          ptr = (char *) &argv[prom_argc + 1];    /* strings follow array */
    
          for (argc = 0; argc < prom_argc; argc++) {
               argv[argc] = ptr;
               strcpy(ptr, prom_argv[argc]);
               ptr += strlen(prom_argv[argc]) + 1;
          }
---
arch/mips/pmcs-msp71xx/msp_prom.c:399
          envp = kmalloc(len, GFP_KERNEL);
          ptr = (char *) &envp[i+1];
    
          for (argc = 0; argc < i; argc++) {
               envp[argc] = ptr;
               strcpy(ptr, prom_envp[argc]);
               ptr += strlen(prom_envp[argc]) + 1;
          }
---
arch/powerpc/platforms/pseries/dlpar.c:389
          hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
                          GFP_KERNEL);
          memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
---
drivers/media/pci/cx23885/cx23885-dvb.c:1477
                    fe0->dvb.frontend->sec_priv = kmalloc(sizeof(dib7000p_ops), GFP_KERNEL);
                    memcpy(fe0->dvb.frontend->sec_priv, &dib7000p_ops, sizeof(dib7000p_ops));
---
/mnt/hgfs/Projekte/linux-master (1)/linux-master/drivers/misc/lkdtm/perms.c:135
          u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
          execute_location(kmalloc_area, CODE_WRITE);
          kfree(kmalloc_area);
     }
---
/mnt/hgfs/Projekte/linux-master (1)/linux-master/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:113
          new_compat = kmalloc(new_len, GFP_KERNEL);
    
          omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
    
          omapdss_update_prop(node, new_compat, new_len);
     }
---
/mnt/hgfs/Projekte/linux-master (1)/linux-master/drivers/staging/media/davinci_vpfe/dm365_ipipe.c:1267
               params = kmalloc(sizeof(struct ipipe_module_params),
                          GFP_KERNEL);
               to = (void *)params + module_if->param_offset;
               size = module_if->param_size;
    
               if (to && from && size) {
                    if (copy_from_user(to, (void __user *)from, size)) {
                         rval = -EFAULT;
                         break;
                    }
---
/mnt/hgfs/Projekte/linux-master (1)/linux-master/drivers/staging/media/davinci_vpfe/dm365_ipipe.c:1309
               params = kmalloc(sizeof(struct ipipe_module_params),
                          GFP_KERNEL);
               from = (void *)params + module_if->param_offset;
               size = module_if->param_size;
    
               if (to && from && size) {
                    rval = module_if->get(ipipe, from);
                    if (rval)
                         goto error;
                    if (copy_to_user((void __user *)to, from, size)) {
---

