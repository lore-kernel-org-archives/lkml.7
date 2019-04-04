Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963102082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQea+On8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDDOKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:10:01 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:37635 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:10:00 -0400
Received: by mail-wr1-f47.google.com with SMTP id w10so4009598wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=bo0Hk5mrD0t9AbxruFivV2mEoNfh3ji8GUUFRiINkpk=;
        b=uQea+On83EaXg60F8+zINz43eONX7ReNl8PFlzDbIMW9kX6I5WS3IhGMenB1Znf0y9
         aSRCLNXwUAoqHTWZwTs7ob9T0o+hmBYgeMoW1s6ddUW0COl1pC/CvvT4WEFYRS+A3NlK
         /tqhAe3xMRJ1pN7IDzx7zfD8KZnedsuVIE+U1J29eMEOgN81h9U8AfYd0drzql7mTiM3
         R7mg9j+CAtKZbPICmiU+GSv68S07Y6Cv91KMDL1mXAJDDZKIsz+ws1gtAOaCvJq5eFt8
         Cu1aA3hRe7ycRwvnUZer5KKxIVJ6lSpwLy+FIiqnEhntaZgb9QeFzW2cLW4O09YTRqHO
         WBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bo0Hk5mrD0t9AbxruFivV2mEoNfh3ji8GUUFRiINkpk=;
        b=o9UqCeBfeh2I0z518JHibgYV81BWyYcXSZDqUoe0E0YG2EhEFOL47sqgMa0zTY1Y0c
         D5oAcRHLDoNtuWRPYhYitQp/G26U0T77n34GfZq+tOfeB7HL2+a0aaQWPDcw52yQFbYw
         QH970/9rfcpWfv6kGpwo1pA1WxETEIsvr1lUBGvz8EmOTWAQPoNm7wZbo2m509zhD9nO
         QzG0BceeFvfszIEnH/d92pkXVsIM6HOBGexx12WyvrctoYNI1X1+KnqHM2sMZcE3Cw2V
         7hrsCJBcAXsI9rNgNaj4K4lYAkFrNhO+kcW7otzk0hkyxsP63spZCLqAoSTGOYufhdGs
         Z8NA==
X-Gm-Message-State: APjAAAWWYFb0Wklr79EhUduEIcFlor+tdF2rzabneN1CcuCk2Th02qk3
        ITom/yzAQHrZk/aRaPAF5aYQdOZR
X-Google-Smtp-Source: APXvYqzWTq7WiyHI5i8mx1K1W+FvanvYF6uAgMjQ3CvZErjzo9n9kkEBNaCPu95ub1HSN0S/XFjHKg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr4540616wrq.176.1554386997993;
        Thu, 04 Apr 2019 07:09:57 -0700 (PDT)
Received: from [192.168.107.155] (x4db7acde.dyn.telefonica.de. [77.183.172.222])
        by smtp.gmail.com with ESMTPSA id z74sm4945614wmc.2.2019.04.04.07.09.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 07:09:56 -0700 (PDT)
Subject: [RESEND] Unsafe kmalloc() calls found
References: <9f3ba19b-70cb-7631-9426-7aabacc1fdb6@gmail.com>
To:     linux-kernel@vger.kernel.org
From:   Oliver Henning <oliver.henning@gmail.com>
X-Forwarded-Message-Id: <9f3ba19b-70cb-7631-9426-7aabacc1fdb6@gmail.com>
Message-ID: <0fc84c29-867d-89f2-a05e-c48e754b7c6f@gmail.com>
Date:   Thu, 4 Apr 2019 16:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9f3ba19b-70cb-7631-9426-7aabacc1fdb6@gmail.com>
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

drivers/misc/lkdtm/perms.c:135
          u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
          execute_location(kmalloc_area, CODE_WRITE);
          kfree(kmalloc_area);
     }
---

drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:113
          new_compat = kmalloc(new_len, GFP_KERNEL);
    
          omapdss_prefix_strcpy(new_compat, new_len, prop->value, prop->length);
    
          omapdss_update_prop(node, new_compat, new_len);
     }
---

drivers/staging/media/davinci_vpfe/dm365_ipipe.c:1267
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

drivers/staging/media/davinci_vpfe/dm365_ipipe.c:1309
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

