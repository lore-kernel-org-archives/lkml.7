Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5646EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197D02173E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wyfb++8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfHVTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:53:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44619 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbfHVTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:53:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so6578605ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9m2iC80j2JIFRIAxgtA8C3dN793XNUSziCXmuQgWo2I=;
        b=Wyfb++8R+UV1t7wnQDbp1AZFqM4dhvQsMp71eLI7uw417WxUc72pzb4Sp24MlUrWXD
         W0M90cqh/QPXvquDGUQQDrYTBS3kJZccD9rtTw9GwyCrpFzpl21H8ax1M+YfnwMjYRj5
         D9yza5PPQ0JePAO1LL4XTTV7e67+tLAd2y7V1V3HPNBwgEnVgf1+emtb5Ek9zs3I7VLU
         P9dnSIUG3SMFi/Z1+N73NxPtOnGGa9sjerbMN1CCXchm3GdbUreFUh3xNy1FzSGi19IG
         zysF16tgr9PuiQC3wiXosGkWnfYGiRJMFUE8Qs6N2gGcozT1TB4QoOzfWvHLIQX84nRs
         MMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9m2iC80j2JIFRIAxgtA8C3dN793XNUSziCXmuQgWo2I=;
        b=VpYmFAc2W8Yfqlc4NCWFFZOgA4iTW4gyopYRTLI/sDvn818gL3nP4W5tMM+9ogKrGj
         Q5TFKFo7VHA0CAzy3FRAoCR7Gc+XNqwVjsWI8PJZOjDdCy3pw0f0iEI+0/R8e/xeYG7D
         fIJREMoukExTTD0F39RUsxIUrAOFFuc0qIXq5oL97LLc2QzWOpsq6evjXuFWvB+H7aaU
         WjXr16GvszoSEhmKf7tjfY3xBsX8UkkSWGSqpO+IP/speMDavQ+Iio/Nr5QNXnxJsDEG
         5eV4DxYG1k9ebVkhQWYOacqgH2OZqO5GnHn7a0+JjaBxJUcwe2lSOY/Z11rtyVkmz/mv
         A0SA==
X-Gm-Message-State: APjAAAX3Vb2jfoaQVp3Y8fPn8aqaLEPLLfM97snbH6kGcorUqlfWps7T
        qlJNHwMW+fPKoC+Vy0y1rR7LBi2ZToMRIO+GwJ5MRZeC
X-Google-Smtp-Source: APXvYqwztqKDwK4AHneSyI5KQg3Y8THAUN+L9G+WENItobim5ymuJYp/RZ3wKeXuKvH/iD09LHkbw+ryWrg0TOZbzVo=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr1118200otg.306.1566503586393;
 Thu, 22 Aug 2019 12:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com> <20190822000933.180870-3-khazhy@google.com>
 <CALvZod5d1iyJtfwzW0qtHLJ4cB5zQqAHuVBM_ay9cWD=TTSPSw@mail.gmail.com>
In-Reply-To: <CALvZod5d1iyJtfwzW0qtHLJ4cB5zQqAHuVBM_ay9cWD=TTSPSw@mail.gmail.com>
From:   Khazhismel Kumykov <khazhy@google.com>
Date:   Thu, 22 Aug 2019 12:52:54 -0700
Message-ID: <CACGdZYJK+Q4Ak5hEj3EDeO3QJ=JNPLJZ=G3HZcGQL9zRoMnbtw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: pass gfp flags to fuse_request_alloc
To:     Shakeel Butt <shakeelb@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d7aeb60590ba09b8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d7aeb60590ba09b8
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 21, 2019 at 5:18 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Aug 21, 2019 at 5:10 PM Khazhismel Kumykov <khazhy@google.com> wrote:
> >
> > Instead of having a helper per flag
> >
> > Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>
> I think it would be better to re-order the patch 2 and 3 of this
> series. There will be less code churn.

That makes sense to me, I'll follow up with a v2

--000000000000d7aeb60590ba09b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFKBLk14axMQMpZ/b8PKcFvP/M5dTMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQBKP0VRR9yRe7hRjO9f
l8vyi9FFUHwUYhQNrCn759p3gcg02mxtS8zV2g/xgJuYRni5WstweUmeTAslWVGNcsYVUOn973Ep
l/19VTDE1G3k+wvs3xY5+Y11hUzgDVsCvuicWAOWAmHgoKEd95uNI30HFT/XRIHAizSXG3uZTciq
c77VPsnICGmrIQnD9UJGknakL8eyVDAcdO1FxpGiWmW1c2eTMf2mqOTrB+1+ixiDCV5Iq7vFY/vk
/OjbOc2/RCcDlA6VNEeLUeSWQe59aQ+YiO1jrgnLn3fMgcE7o3t3Lah9K3fFRP8foYGcx8XOESWI
zZM9o9E2BY7eSO1XYXxyMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMTewG74t+
Y00MjT2SMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCChmHlSY2HVV8CMeNqkZjoQ
Fdb+JH+8YZ/Sq43KPzCTYTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xOTA4MjIxOTUzMDdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHASEVwWYM1XCGU2oW3Jkm1qU36BMcEcjhGMbYT2X
LTKmqv6slLX0Erj9syWeGApwk6oWMdDo4UbHcHKGrTASbxA1KcX90ynrbzZ4WtYHaeRcq7ES08++
XtfAwRe+z7xLpWDwmsfqtZsveku2X0JoWPYH+NQqtE/gsGY4gQDMVxED5bKeX5zwySdBLnDSuwt9
Lmw0+1sjaTjeLaIrgv2N2DlqlrQQifEcpDeVRjSfowE6xG9vEnQwd9teg+hEkNyFOP9fcQnR26hS
E8zYTmooVxjCcbYVDg3K3F1tOBEQxYMCvvhExaMLv7xVibs0foW6z7YjGPLrnT/h3O1HHw8SbA==
--000000000000d7aeb60590ba09b8--
